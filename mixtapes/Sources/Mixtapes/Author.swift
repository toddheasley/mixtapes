import Foundation

public struct Author: Codable, CustomStringConvertible {
    public let url: URL
    public let name: String?
    
    public init(url: URL, name: String? = nil) {
        self.url = url
        self.name = name
    }
    
    // MARK: CustomStringConvertible
    public var description: String {
        return name ?? url.absoluteString
    }
}
