import Cocoa

struct Favicon: Resource {
    init(icon: Icon) throws {
        url = URL(fileURLWithPath: "favicon.ico", relativeTo: icon.url)
        guard let data: Data = try? NSImage(data: icon.data)?.pngData(CGSize(width: 64.0, height: 64.0)) else {
            throw Error("Favicon conversion failed", url: url)
        }
        self.data = data
    }
    
    // MARK: Resource
    public let url: URL
    public let data: Data
}
