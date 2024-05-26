import Foundation

struct JSONFeed: Resource {
    init(index: Index) throws {
        data = try JSONEncoder(url: index.url, formatting: [.sortedKeys]).encode(index)
        url = index.url
    }
    
    // MARK: Resource
    let data: Data
    let url: URL
}
