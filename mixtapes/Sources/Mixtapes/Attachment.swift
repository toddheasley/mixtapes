import Foundation

public struct Attachment {
    public let asset: Asset
    
    public var url: URL {
        return asset.url
    }
    
    public var mimeType: String {
        return asset.mimeType
    }
    
    public var sizeInBytes: Int {
        return asset.length
    }
    
    public var durationInSeconds: Int {
        return Int(asset.duration)
    }
    
    init(asset: Asset) {
        self.asset = asset
    }
}

extension Attachment: Codable {
    
    // MARK: Codable
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        try container.encode(URL(string: url.lastPathComponent, relativeTo: try encoder.url())!, forKey: .url)
        try container.encode(mimeType, forKey: .mimeType)
        try container.encode(sizeInBytes, forKey: .sizeInBytes)
        try container.encode(durationInSeconds, forKey: .durationInSeconds)
    }
    
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Key> = try decoder.container(keyedBy: Key.self)
        let path: String = try container.decode(URL.self, forKey: .url).lastPathComponent
        guard path.count > 1 else {
            throw DecodingError.valueNotFound(URL.self, DecodingError.Context(codingPath: [], debugDescription: ""))
        }
        let url: URL = URL(fileURLWithPath: path, relativeTo: try decoder.url())
        self.asset = try Asset(url: url)
    }
    
    private enum Key: String, CodingKey {
        case url, mimeType = "mime_type", title, sizeInBytes = "size_in_bytes", durationInSeconds = "duration_in_seconds"
    }
}
