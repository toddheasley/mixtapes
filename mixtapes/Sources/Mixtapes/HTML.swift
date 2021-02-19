import Foundation

struct HTML: Resource {
    init(index: Index) {
        url = URL(fileURLWithPath: "\(index.id).html", relativeTo: index.url)
        data = Data()
    }
    
    // MARK: Resource
    public let url: URL
    public let data: Data
}
