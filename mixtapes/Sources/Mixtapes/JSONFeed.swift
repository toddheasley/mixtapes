import Foundation

struct JSONFeed: Resource {
    init(index: Index) throws {
        data = try JSONEncoder(url: index.url, formatting: [.sortedKeys]).encode(index)
        url = index.url
    }
    
    // MARK: Resource
    public let data: Data
    public let url: URL
}
