import Foundation

struct Site: Resource {
    init(index: Index) throws {
        let html: HTMLPage = HTMLPage(index: index)
        url = html.url
        data = html.data
        var resources: [Resource] = [
            try Favicon(icon: index.icon),
            try Bookmark(icon: index.icon),
            try Stylesheet(url: index.url),
            try RSSIcon(url: index.url),
            RSSFeed(index: index)
        ]
        for item in index.items {
            resources.append(HTMLPage(index: index, item: item))
        }
        self.resources = resources
    }
    
    // MARK: Resource
    public let url: URL
    public let data: Data
    public let resources: [Resource]
}
