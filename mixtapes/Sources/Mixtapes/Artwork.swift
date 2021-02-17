import Foundation

public struct Artwork: Resource {
    init(_ data: Data?, url: URL) throws {
        guard let data: Data = data,
            let id: String = url.id else {
            throw Error("Artwork not found", url: url)
        }
        guard let pathExtension: String = data.pathExtension else {
            throw Error("Artwoark not PNG or JPEG", url: url)
        }
        self.url = URL(fileURLWithPath: "\(id).\(pathExtension)", relativeTo: url)
        self.data = data
    }
    
    // MARK: Resource
    public let url: URL
    public let data: Data
}
