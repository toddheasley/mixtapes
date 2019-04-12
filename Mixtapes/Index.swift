import Foundation

public struct Index {
    public let title: String = "Todd's Mixtapes"
    public let description: String = "Love letters to my favorite music"
    public let author: (url: URL, description: String) = (URL(string: "https://twitter.com/toddheasley")!, "@toddheasley")
    public private(set) var link: URL = URL(string: "https://s3.amazonaws.com/toddheasley/mixtapes")!
    public private(set) var url: URL
    public private(set) var artwork: Resource
    public private(set) var assets: [Asset]
    
    public func write() throws {
        for asset in assets {
            try asset.artwork.write()
        }
        try artwork.write()
        try HTMLResource(index: self).write()
    }
    
    public init(url: URL) throws {
        self.url = URL(fileURLWithPath: "index.txt", relativeTo: url)
        assets = try String(contentsOf: self.url).components(separatedBy: "\n").map { path in
            return try Asset(url: URL(fileURLWithPath: "assets/\(path).m4a", relativeTo: url))
        }
        artwork = Resource(url: URL(fileURLWithPath: "artwork.jpg", relativeTo: url), data: assets.first?.artwork.data ?? Data())
    }
}

extension Index {
    public static func configure(url: URL) throws {
        let assets: URL = URL(fileURLWithPath: "assets", relativeTo: url)
        if !FileManager.default.fileExists(atPath: assets.path) {
            try FileManager.default.createDirectory(at: assets, withIntermediateDirectories: false, attributes: nil)
        }
        let url: URL = URL(fileURLWithPath: "index.txt", relativeTo: url)
        if !FileManager.default.fileExists(atPath: url.path) {
            try "".data(using: .utf8)!.write(to: url)
        }
    }
}
