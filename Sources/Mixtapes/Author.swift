import Foundation

public struct Author {
    public let url: URL
    public let name: String?
    
    public init(url: URL, name: String? = nil) {
        self.url = url
        if let name: String = name, !name.isEmpty {
            self.name = name
        } else if url.absoluteString.hasPrefix("mailto:") {
            let name: String = url.absoluteString.replacingOccurrences(of: "mailto:", with: "")
            self.name = !name.isEmpty ? name : nil
        } else if (url.host ?? "").contains("github.com"),
            url.pathComponents.count > 1, !url.pathComponents[1].isEmpty {
            self.name = "@\(url.pathComponents[1])"
        } else {
            self.name = nil
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
