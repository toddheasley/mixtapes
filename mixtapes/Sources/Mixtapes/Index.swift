import Foundation

public struct Index: Identifiable, CustomStringConvertible {
    public let url: URL
    public let icon: Icon
    public var title: String = ""
    public var isExpired: Bool = false
    public var authors: [Author] = []
    
    public var items: [Item] = [] {
        didSet {
            let sortedItems: [Item] = items.sorted { $0.date.published > $1.date.published }
            guard items != sortedItems else {
                return
            }
            items = sortedItems
        }
    }
    
    public var homepage: String {
        set {
            homepageURL = URL(homepage: newValue, path: "index.html")
        }
        get { homepageURL?.baseURL?.absoluteString ?? "" }
    }
    
    public func write() throws {
        for item in items {
            try item.attachment.asset.artwork.write()
        }
        try icon.write()
        try HTML(index: self).write()
        try JSON(index: self).write()
    }
    
    public init(url: URL) throws {
        guard FileManager.default.fileExists(atPath: url.path) else {
            throw Error("Resource not found", url: url)
        }
        do {
            let url: URL = URL(fileURLWithPath: "\(id).json", relativeTo: url)
            if FileManager.default.fileExists(atPath: url.path) {
                self = try JSONDecoder(url: url).decode(Self.self, from: try Data(contentsOf: url))
            } else {
                self.url = url
                self.icon = Icon(url: url)
            }
        } catch {
            throw Error("Feed decoding failed", url: url)
        }
    }
    
    private(set) var homepageURL: URL?
    
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
    
    // MARK: CustomStringConvertible
    public var description: String = ""
}

extension Index: Codable {
    
    // MARK: Codable
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        try container.encode("https://jsonfeed.org/version/1.1", forKey: .version)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        if isExpired {
            try container.encode(isExpired, forKey: .expired)
        }
        try container.encode(items, forKey: .items)
        if !authors.isEmpty {
            try container.encode(authors, forKey: .authors)
        }
        if let homepageURL: URL = homepageURL {
            try container.encode(homepageURL, forKey: .homepageURL)
            try container.encode(feedURL!, forKey: .feedURL)
            try container.encode(iconURL!, forKey: .icon)
        }
    }
    
    public init(from decoder: Decoder) throws {
        url = try decoder.url()
        let container: KeyedDecodingContainer<Key> = try decoder.container(keyedBy: Key.self)
        icon = Icon(url: url, path: (try? container.decode(URL.self, forKey: .icon))?.lastPathComponent)
        title = try container.decode(String.self, forKey: .title)
        isExpired = (try? container.decode(Bool.self, forKey: .expired)) ?? isExpired
        items = try container.decode([Item].self, forKey: .items)
        authors = (try? container.decode([Author].self, forKey: .authors)) ?? []
        description = try container.decode(String.self, forKey: .description)
        homepage = (try? container.decode(URL.self, forKey: .homepageURL))?.absoluteString ?? ""
    }
    
    private enum Key: String, CodingKey {
        case version, icon, title, homepageURL = "home_page_url", feedURL = "feed_url", description, expired, items, authors
    }
}
