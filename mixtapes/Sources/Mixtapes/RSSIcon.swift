import Foundation

public struct RSSIcon: Resource {
    init(url: URL) throws {
        let path: String = "rss.svg"
        self.url = URL(fileURLWithPath: path, relativeTo: url)
        data = try Bundle.module.resource(path)
    }
    
    // MARK: Resource
    public let url: URL
    public let data: Data
}
