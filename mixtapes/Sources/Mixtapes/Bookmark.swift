import Cocoa

struct Bookmark: Resource {
    init(icon: Icon) throws {
        url = URL(fileURLWithPath: "apple-touch-icon.png", relativeTo: icon.url)
        guard let data: Data = try? NSImage(data: icon.data)?.pngData(CGSize(width: 152.0, height: 152.0)) else {
            throw Error("Bookmark conversion failed", url: url)
        }
        self.data = data
    }
    
    // MARK: Resource
    public let url: URL
    public let data: Data
}
