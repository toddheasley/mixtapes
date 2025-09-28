import Foundation

struct Site: Resource {
    init(index: Index) throws {
        let html: HTMLPage = HTMLPage(.index, index: index)
        data = html.data
        resources = [
            try Favicon(url: index.url),
            try Bookmark(icon: index.icon),
            try Stylesheet(url: index.url),
            RSSFeed(index: index),
        ] + index.items.map { HTMLPage(.item($0), index: index) }
        url = html.url
    }
    
    // MARK: Resource
    let data: Data
    let resources: [Resource]
    let url: URL
}
