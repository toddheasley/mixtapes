import Foundation

public struct Author: Codable, CustomStringConvertible {
    public let url: String
    public let name: String?
    
    public init(_ url: String, name: String? = nil) {
        self.url = url
        self.name = name
    }
    
    // MARK: CustomStringConvertible
    public var description: String {
        return name ?? url
    }
}
