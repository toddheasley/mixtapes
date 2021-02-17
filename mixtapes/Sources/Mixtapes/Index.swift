import Foundation

public struct Index: Identifiable, CustomStringConvertible {
    public let url: URL
    public let icon: Icon
    public var title: String = ""
    public var isExpired: Bool = false
    public var items: [Item] = []
    public var author: Author?
    public var homepageURL: URL?
    
    public var feedURL: URL? {
        return homepageURL != nil ? URL(string: url.lastPathComponent, relativeTo: homepageURL!) : nil
    }
    
    public var iconURL: URL? {
        return homepageURL != nil ? URL(string: icon.url.lastPathComponent, relativeTo: homepageURL!) : nil
    }
    
    public func write() throws {
        for item in items {
            try item.attachment.asset.artwork.write()
        }
        try icon.write()
        
        // try JSON(index: self).write()
        // try RSS(index: self).write()
        // try HTML(index: self).write()
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
        if let author: Author = author {
            try container.encode(author, forKey: .author)
        }
        if let homepageURL: URL = homepageURL {
            try container.encode(homepageURL, forKey: .homepageURL)
        }
        if let feedURL: URL = feedURL {
            try container.encode(feedURL, forKey: .feedURL)
        }
        if let iconURL: URL = iconURL {
            try container.encode(iconURL, forKey: .icon)
        }
    }
    
    public init(from decoder: Decoder) throws {
        url = try decoder.url()
        let container: KeyedDecodingContainer<Key> = try decoder.container(keyedBy: Key.self)
        icon = Icon(url: url, path: (try? container.decode(URL.self, forKey: .icon))?.lastPathComponent)
        title = try container.decode(String.self, forKey: .title)
        homepageURL = try? container.decode(URL.self, forKey: .homepageURL)
        isExpired = (try? container.decode(Bool.self, forKey: .expired)) ?? isExpired
        items = try container.decode([Item].self, forKey: .items)
        author = try? container.decode(Author.self, forKey: .author)
        description = try container.decode(String.self, forKey: .description)
    }
    
    private enum Key: String, CodingKey {
        case version, icon, title, homepageURL = "home_page_url", feedURL = "feed_url", description, expired, items, author
    }
}
