import Foundation

struct Favicon: Resource {
    init(url: URL) throws {
        self.url = URL(fileURLWithPath: "favicon.ico", relativeTo: url)
        data = try Bundle.module.resource("favicon.png")
    }
    
    // MARK: Resource
    let data: Data
    let url: URL
}
