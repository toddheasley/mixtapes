import Foundation

public struct Index: Identifiable, Equatable, CustomStringConvertible {
    public let url: URL
    public var title: String = ""
    public var homepage: String = ""
    public var icon: Icon
    public var authors: [Author] = []
    public var isExpired: Bool = false
    
    public var items: [Item] = [] {
        didSet {
            let sortedItems: [Item] = items.sorted { $0.metadata.published > $1.metadata.published }
            guard items != sortedItems else { return }
            items = sortedItems
        }
    }
    
    public func write() throws {
        try JSONFeed(index: self).write()
        for item in items {
            try item.attachment.asset.artwork.write()
        }
        try icon.write()
        try Site(index: self).write()
    }
    
    public init(url: URL?) async throws {
        guard let url else {
            throw Error("Resource URL not found")
        }
        guard FileManager.default.fileExists(atPath: url.path) else {
            throw Error("Resource not found", url: url)
        }
        do {
            let url: URL = URL(fileURLWithPath: "\(id).json", relativeTo: url)
            if FileManager.default.fileExists(atPath: url.path) {
                let metadata: Metadata = try JSONDecoder(url: url).decode(Metadata.self, from: Data(contentsOf: url))
                self = try await Self(metadata: metadata)
            } else {
                let metadata: Metadata = try Metadata(url: url)
                self = try await Self(metadata: metadata)
            }
        } catch {
            throw Error("Feed decoding failed", url: url)
        }
    }
    
    struct Metadata: CustomStringConvertible {
        let url: URL
        let title: String
        var homepage: String = ""
        let icon: Icon
        let authors: [Author]
        let isExpired: Bool
        let items: [Item.Metadata]
        
        init(url: URL) throws {
            self.url = url
            self.title = ""
            self.icon = try Icon(url: url)
            self.authors = []
            self.isExpired = false
            self.items = []
            self.description = ""
        }
        
        // MARK: CustomStringConvertible
        let description: String
    }
    
    init(metadata: Metadata) async throws {
        url = metadata.url
        for metadata in metadata.items {
            print("*** \(metadata.url.absoluteString)")
            let item: Item = try await Item(metadata: metadata)
            items.append(item)
        }
        title = metadata.title
        homepage = metadata.homepage
        icon = metadata.icon
        authors = metadata.authors
        isExpired = metadata.isExpired
        description = metadata.description
    }
    
    var homepageURL: URL? { URL(homepage: homepage, path: "index.html") }
    var feedURL: URL? { URL(homepage: homepage, path: url.lastPathComponent) }
    var iconURL: URL? { URL(homepage: homepage, path: icon.url.lastPathComponent) }
    
    func itemURL(_ item: Item) -> (attachment: URL, image: URL, link: URL)? {
        guard let attachment: URL = URL(homepage: homepage, path: item.attachment.url.lastPathComponent),
              let image: URL = URL(homepage: homepage, path: item.image.lastPathComponent),
              let link: URL = URL(homepage: homepage, path: "\(item.id).html") else {
            return nil
        }
        return (attachment, image, link)
    }
    
    // MARK: Identifiable
    public private(set) var id: String = "index"
    
    // MARK: Equatable
    public static func ==(lhs: Self, rhs: Self) -> Bool { lhs.id == rhs.id }
    
    // MARK: CustomStringConvertible
    public var description: String = ""
}

extension Index: Encodable {
    
    // MARK: Encodable
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        try container.encode("https://jsonfeed.org/version/1.1", forKey: .version)
        try container.encode(title, forKey: .title)
        if let homepageURL {
            try container.encode(homepageURL, forKey: .homepageURL)
        } else if !homepage.isEmpty {
            try container.encode(homepage, forKey: .homepageURL)
        }
        try container.encodeIfPresent(feedURL, forKey: .feedURL)
        try container.encode(description, forKey: .description)
        try container.encodeIfPresent(iconURL, forKey: .icon)
        if !authors.isEmpty {
            try container.encode(authors, forKey: .authors)
        }
        if isExpired {
            try container.encode(isExpired, forKey: .expired)
        }
        try container.encode(items, forKey: .items)
    }
}

extension Index.Metadata: Decodable {
    
    // MARK: Decodable
    init(from decoder: Decoder) throws {
        url = try decoder.url()
        let container: KeyedDecodingContainer<Key> = try decoder.container(keyedBy: Key.self)
        title = try container.decode(String.self, forKey: .title)
        if let homepage: String = try? container.decode(String.self, forKey: .homepageURL) {
            self.homepage = URL(homepage: homepage)?.absoluteString ?? homepage
        }
        description = try container.decode(String.self, forKey: .description)
        icon = try Icon(url: url, path: (try? container.decode(URL.self, forKey: .icon))?.lastPathComponent)
        authors = (try? container.decode([Author].self, forKey: .authors)) ?? []
        isExpired = (try? container.decode(Bool.self, forKey: .expired)) ?? false
        items = try container.decode([Item.Metadata].self, forKey: .items)
    }
}

private enum Key: String, CodingKey {
    case version, title, homepageURL = "home_page_url", feedURL = "feed_url", description, icon, authors, expired, items
}
