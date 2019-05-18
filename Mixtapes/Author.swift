import Foundation

public struct Author {
    public var url: URL
    
    public var name: String? {
        didSet {
            if let name: String = name, name.isEmpty {
                self.name = nil
            }
        }
    }
    
    public var suggestedName: String? {
        if url.absoluteString.hasPrefix("mailto:") {
            return url.absoluteString.replacingOccurrences(of: "mailto:", with: "")
        } else if (url.host ?? "").contains("twitter.com"),
            url.pathComponents.count > 1, !url.pathComponents[1].isEmpty {
            return "@\(url.pathComponents[1])"
        }
        return nil
    }
    
    public init(url: URL, name: String? = nil) {
        self.url = url
        if let name: String = name, !name.isEmpty {
            self.name = name
        }
    }
}

extension Author: CustomStringConvertible {
    
    // MARK: CustomStringConvertible
    public var description: String {
        return name ?? url.absoluteString
    }
}

extension Author: Codable {
    
    // MARK: Codable
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Key> = try decoder.container(keyedBy: Key.self)
        self.url = try container.decode(URL.self, forKey: .url)
        self.name = try? container.decode(String.self, forKey: .name)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        try container.encode(url, forKey: .url)
        try? container.encode(name, forKey: .name)
    }
    
    private enum Key: CodingKey {
        case url, name
    }
}
