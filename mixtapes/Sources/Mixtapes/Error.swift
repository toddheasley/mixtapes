import Foundation

public struct Error: Swift.Error, Identifiable, CustomStringConvertible {
    public let url: URL?
    
    public init(_ description: String, url: URL? = nil) {
        if let url: URL = url {
            self.description = "\(description): \(url)"
        } else {
            self.description = description
        }
        self.url = url
    }
    
    init?(_ error: Swift.Error) {
        guard let error: Error = error as? Error else {
            return nil
        }
        self = error
    }
    
    // MARK: Identifiable
    public var id: String {
        return description
    }
    
    // MARK: CustomStringConvertible
    public let description: String
}
