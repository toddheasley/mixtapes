import Foundation

public struct Error: Swift.Error, Equatable, Identifiable, CustomStringConvertible {
    public let url: URL?
    
    public init(_ description: String, url: URL? = nil) {
        if let url: URL = url {
            self.description = "\(description): \(url.absoluteString)"
        } else {
            self.description = description
        }
        self.url = url
    }
    
    init?(_ error: Swift.Error) {
        guard let error: Error = error as? Error else { return nil }
        self = error
    }
    
    // MARK: Identifiable
    public var id: String { description }
    
    // MARK: CustomStringConvertible
    public let description: String
}
