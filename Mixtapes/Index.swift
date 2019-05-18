import Foundation

public struct Index {
    public private(set) var version: URL = URL(string: "https://jsonfeed.org/version/1")!
    public private(set) var url: URL
    public private(set) var icon: Resource?
    public var title: String = ""
    public var homepage: URL = URL(string: "https://s3.amazonaws.com/")!
    public var author: Author?
    public var isExpired: Bool = false
    public var items: [Item] = []
    
    public var description: String? {
        didSet {
            if let description: String = description, description.isEmpty {
                self.description = nil
            }
        }
    }
    
    public var feed: URL {
        return .feed(relativeTo: homepage)
    }
    
    mutating public func icon(data: Data?) {
        if let data: Data = data {
            icon = Resource(url: .icon(relativeTo: url), data: data)
        } else {
            icon = nil
        }
    }
    
    public func write() throws {
        for item in items {
            try item.attachment.asset.artwork.write()
        }
        try icon?.write()
        try JSONEncoder(url: homepage, formatting: [.prettyPrinted, .sortedKeys]).encode(self).write(to: .feed(relativeTo: url))
        try RSS(index: self).write()
        try HTML(index: self).write()
    }
    
    public init(url: URL) throws {
        guard FileManager.default.fileExists(atPath: url.path) else {
            throw Resource.Error.resourceNotFound
        }
        if !FileManager.default.fileExists(atPath: URL.assets(relativeTo: url).path) {
            try FileManager.default.createDirectory(at: .assets(relativeTo: url), withIntermediateDirectories: false, attributes: nil)
        }
        self.url = url
        if FileManager.default.fileExists(atPath: URL.feed(relativeTo: url).path) {
            self = try JSONDecoder(url: url).decode(Index.self, from: try Data(contentsOf: .feed(relativeTo: url)))
        }
    }
}

extension Index: Codable {
    
    // MARK: Codable
    public init(from decoder: Decoder) throws {
        url = URL.feed(relativeTo: try decoder.url())
        let container: KeyedDecodingContainer<Key> = try decoder.container(keyedBy: Key.self)
        title = try container.decode(String.self, forKey: .title)
        homepage = try container.decode(URL.self, forKey: .homepage)
        description = try? container.decode(String.self, forKey: .description)
        author = try? container.decode(Author.self, forKey: .author)
        isExpired = (try? container.decode(Bool.self, forKey: .expired)) ?? false
        items = try container.decode([Item].self, forKey: .items)
        icon(data: try? Data(contentsOf: .icon(relativeTo: self.url)))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        try container.encode(version, forKey: .version)
        try container.encode(title, forKey: .title)
        try container.encode(homepage, forKey: .homepage)
        try container.encode(feed, forKey: .feed)
        if let description: String = description, !description.isEmpty {
            try container.encode(description, forKey: .description)
        }
        if let icon: Resource = icon {
            try container.encode(URL(string: icon.url.relativePath, relativeTo: try encoder.url())!, forKey: .icon)
        }
        if let author: Author = author {
            try container.encode(author, forKey: .author)
        }
        if isExpired {
            try container.encode(isExpired, forKey: .expired)
        }
        try container.encode(items, forKey: .items)
    }
    
    private enum Key: String, CodingKey {
        case version, title, homepage = "home_page_url", feed = "feed_url", description, icon, author, expired, items
    }
}

extension URL {
    static func assets(relativeTo url: URL) -> URL {
        return URL(fileURLWithPath: "assets/", relativeTo: url)
    }
    
    fileprivate static func feed(relativeTo url: URL) -> URL {
        return URL(fileURLWithPath: "index.json", relativeTo: url)
    }
    
    fileprivate static func icon(relativeTo url: URL) -> URL {
        return URL(fileURLWithPath: "icon.jpg", relativeTo: url)
    }
}
