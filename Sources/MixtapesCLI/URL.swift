import Foundation
import ArgumentParser

extension URL: ExpressibleByArgument {
    
    // MARK: ExpressibleByArgument
    public init?(argument: String) {
        guard let url: URL = URL(string: argument), !(url.scheme ?? "").isEmpty else {
            return nil
        }
        self = url
    }
}
