import Foundation

public struct Artwork: Sendable, Resource {
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
    public let data: Data
    public let url: URL
}
