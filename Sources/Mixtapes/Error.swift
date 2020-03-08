import Foundation

public struct Error: Swift.Error, CustomStringConvertible {
    public let url: URL?
    
    public init(_ description: String, url: URL? = nil) {
        if let url: URL = url {
            self.description = "\(description) '<\(url.relativePath)>'"
        } else {
            self.description = description
        }
        self.url = url
    }
    
    // MARK: CustomStringConvertible
    public let description: String
}
