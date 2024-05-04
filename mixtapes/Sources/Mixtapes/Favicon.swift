import Cocoa

import Foundation
import UniformTypeIdentifiers

public struct Favicon: Resource {
    init(url: URL) throws {
        data = try Bundle.module.resource("favicon.png")
        self.url = URL(fileURLWithPath: "favicon.ico", relativeTo: url)
    }
    
    // MARK: Resource
    public let data: Data
    public let url: URL
}
