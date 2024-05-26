import Foundation

public struct Attachment {
    public var mimeType: String { asset.mimeType }
    public var sizeInBytes: Int { asset.length }
    public var durationInSeconds: Int { Int(asset.duration) }
    public var url: URL { asset.url }
    public let asset: Asset
    
    public init(url: URL) async throws {
        let asset: Asset = try await Asset(url: url)
        self.init(asset: asset)
    }
    
    init(asset: Asset) {
        self.asset = asset
    }
}

extension Attachment: Encodable {
    
    // MARK: Encodable
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        try container.encode(URL(string: url.lastPathComponent, relativeTo: try encoder.url())!, forKey: .url)
        try container.encode(mimeType, forKey: .mimeType)
        try container.encode(sizeInBytes, forKey: .sizeInBytes)
        try container.encode(durationInSeconds, forKey: .durationInSeconds)
    }
}

private enum Key: String, CodingKey {
    case mimeType = "mime_type"
    case sizeInBytes = "size_in_bytes"
    case durationInSeconds = "duration_in_seconds"
    case url
}
