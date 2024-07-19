import AppKit

struct Bookmark: Resource {
    init(icon: Icon) throws {
        url = URL(fileURLWithPath: "apple-touch-icon.png", relativeTo: icon.url)
        guard let data: Data = try? NSImage(data: icon.data)?.pngData(CGSize(width: 256.0, height: 256.0)) else {
            throw Error("Bookmark conversion failed", url: url)
        }
        self.data = data
    }
    
    // MARK: Resource
    let data: Data
    let url: URL
}
