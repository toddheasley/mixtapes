import UIKit

struct Favicon: Resource {
    init(icon: Icon) throws {
        url = URL(fileURLWithPath: "favicon.ico", relativeTo: icon.url)
        guard let data: Data = UIImage(data: icon.data)?.resized(CGSize(width: 64.0, height: 64.0))?.pngData() else {
            throw Error("Favicon conversion failed", url: url)
        }
        self.data = data
    }
    
    // MARK: Resource
    public let url: URL
    public let data: Data
}
