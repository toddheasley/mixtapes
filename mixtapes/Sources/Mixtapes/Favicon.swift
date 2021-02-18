import UIKit

struct Favicon: Resource {
    init(icon: Icon) throws {
        url = URL(fileURLWithPath: "favicon.ico", relativeTo: icon.url)
        guard let image: UIImage = UIImage(data: icon.data) else {
            throw Error("Favicon not renderable", url: url)
        }
        data = icon.data
    }
    
    // MARK: Resource
    public let url: URL
    public let data: Data
}
