import Foundation

struct Error: Swift.Error, CustomStringConvertible {
    let url: URL?
    
    init(_ description: String, url: URL? = nil) {
        if let url: URL = url {
            self.description = "\(description) \(url.relativePath)"
        } else {
            self.description = description
        }
        self.url = url
    }
    
    // MARK: CustomStringConvertible
    let description: String
}
