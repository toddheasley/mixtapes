import Foundation

public struct Author: Sendable, Codable, CustomStringConvertible {
    public let name: String?
    public let url: String
    
    public init(_ name: String? = nil, url: String) {
        self.name = name
        self.url = url
    }
    
    // MARK: CustomStringConvertible
    public var description: String { name ?? url }
}
