import UIKit

struct Bookmark: Resource {
    init(icon: Icon) throws {
        url = URL(fileURLWithPath: "apple-touch-icon.png", relativeTo: icon.url)
        guard let data: Data = UIImage(data: icon.data)?.resized(CGSize(width: 152.0, height: 152.0))?.pngData() else {
            throw Error("Bookmark conversion failed", url: url)
        }
        self.data = data
    }
    
    // MARK: Resource
    public let url: URL
    public let data: Data
}
