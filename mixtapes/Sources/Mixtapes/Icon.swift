import Foundation
import UniformTypeIdentifiers

public struct Icon: Resource {
    public static let contentTypes: [UTType] = [.png, .jpeg]
    
    public static var data: Data {
        return try! Bundle.module.resource("icon.png")
    }
    
    public mutating func reset(_ data: Data? = nil) throws {
        guard let data: Data = data ?? (try? Bundle.module.resource("icon.png")),
              let pathExtension: String = data.pathExtension else {
            throw Error("Icon not PNG or JPEG")
        }
        url = URL(fileURLWithPath: "icon.\(pathExtension)", relativeTo: url)
        self.data = data
    }
    
    init(url: URL, path: String? = nil) throws {
        self.url = url
        try? reset()
        try? reset(try Data(contentsOf: URL(fileURLWithPath: path ?? "", relativeTo: url)))
    }
    
    // MARK: Resource
    public private(set) var url: URL
    public private(set) var data: Data = Data()
}
