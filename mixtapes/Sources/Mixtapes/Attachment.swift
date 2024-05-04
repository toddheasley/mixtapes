import Foundation

public struct Attachment {
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
    
    public init(url: URL) async throws {
        let asset: Asset = try await Asset(url: url)
        self.init(asset: asset)
    }
    
    init(asset: Asset) {
        self.asset = asset
    }
    
    let asset: Asset
}

extension Attachment: Encodable {
    
    // MARK: Codable
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        try container.encode(URL(string: url.lastPathComponent, relativeTo: try encoder.url())!, forKey: .url)
        try container.encode(mimeType, forKey: .mimeType)
        try container.encode(sizeInBytes, forKey: .sizeInBytes)
        try container.encode(durationInSeconds, forKey: .durationInSeconds)
    }
    
    private enum Key: String, CodingKey {
        case url, mimeType = "mime_type", title, sizeInBytes = "size_in_bytes", durationInSeconds = "duration_in_seconds"
    }
}
