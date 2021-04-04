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
            let sortedItems: [Item] = items.sorted { $0.date.published > $1.date.published }
            guard items != sortedItems else {
                return
            }
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
    
    public init(url: URL?) throws {
        guard let url: URL = url else {
            throw Error("Resource URL not found")
        }
        guard FileManager.default.fileExists(atPath: url.path) else {
            throw Error("Resource not found", url: url)
        }
        do {
            let url: URL = URL(fileURLWithPath: "\(id).json", relativeTo: url)
            if FileManager.default.fileExists(atPath: url.path) {
                self = try JSONDecoder(url: url).decode(Self.self, from: try Data(contentsOf: url))
            } else {
                self.url = url
                self.icon = try Icon(url: url)
            }
        } catch {
            throw Error("Feed decoding failed", url: url)
        }
    }
    
    var homepageURL: URL? {
        return URL(homepage: homepage, path: "index.html")
    }
    
    var feedURL: URL? {
        return URL(homepage: homepage, path: url.lastPathComponent)
    }
    
    var iconURL: URL? {
        return URL(homepage: homepage, path: icon.url.lastPathComponent)
    }
    
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
    public static func ==(lhs: Index, rhs: Index) -> Bool {
        return lhs.id == rhs.id
    }
    
    // MARK: CustomStringConvertible
    public var description: String = ""
}

extension Index: Codable {
    
    // MARK: Codable
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        try container.encode("https://jsonfeed.org/version/1.1", forKey: .version)
        try container.encode(title, forKey: .title)
        if let homepageURL: URL = homepageURL {
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
    
    public init(from decoder: Decoder) throws {
        url = try decoder.url()
        let container: KeyedDecodingContainer<Key> = try decoder.container(keyedBy: Key.self)
        title = try container.decode(String.self, forKey: .title)
        if let homepage: String = try? container.decode(String.self, forKey: .homepageURL) {
            self.homepage = URL(homepage: homepage)?.absoluteString ?? homepage
        }
        description = try container.decode(String.self, forKey: .description)
        icon = try Icon(url: url, path: (try? container.decode(URL.self, forKey: .icon))?.lastPathComponent)
        authors = (try? container.decode([Author].self, forKey: .authors)) ?? []
        isExpired = (try? container.decode(Bool.self, forKey: .expired)) ?? isExpired
        items = try container.decode([Item].self, forKey: .items)
    }
    
    private enum Key: String, CodingKey {
        case version, title, homepageURL = "home_page_url", feedURL = "feed_url", description, icon, authors, expired, items
    }
}
