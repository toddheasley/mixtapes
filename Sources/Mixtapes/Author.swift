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
        } else if (url.host ?? "").contains("github.com"),
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
    
}
