import Foundation

public struct RSSIcon: Resource {
    init(url: URL) throws {
        let path: String = "rss.svg"
        data = try Bundle.module.resource(path)
        self.url = URL(fileURLWithPath: path, relativeTo: url)
    }
    
    // MARK: Resource
    public let data: Data
    public let url: URL
}
