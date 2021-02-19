import Foundation

struct JSON: Resource {
    init(index: Index) throws {
        url = index.url
        guard let url: URL = index.homepageURL else {
            throw Error("URL not found", url: self.url)
        }
        data = try JSONEncoder(url: url, formatting: [.sortedKeys]).encode(index)
    }
    
    // MARK: Resource
    public let url: URL
    public let data: Data
}
