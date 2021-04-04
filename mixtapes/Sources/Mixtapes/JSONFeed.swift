import Foundation

struct JSONFeed: Resource {
    init(index: Index) throws {
        url = index.url
        data = try JSONEncoder(url: url, formatting: [.sortedKeys]).encode(index)
    }
    
    // MARK: Resource
    public let url: URL
    public let data: Data
}
