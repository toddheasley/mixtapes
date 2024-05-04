import Foundation

public struct Item: Identifiable, Equatable {
    public struct Metadata {
        public var published: Date
        public var isExplicit: Bool
        let url: URL
        
        init(url: URL, published: Date, isExplicit: Bool) {
            self.published = published
            self.isExplicit = isExplicit
            self.url = url
        }
    }
    
    public let attachment: Attachment
    public var metadata: Metadata
    
    public var title: String { attachment.asset.title }
    public var summary: String { attachment.asset.artist }
    public var image: URL { attachment.asset.artwork.url }
    
    public init(url: URL, published: Date = Date(), isExplicit: Bool = false) async throws {
        try await self.init(metadata: Metadata(url: url, published: published, isExplicit: isExplicit))
    }
    
    init(metadata: Metadata) async throws {
        let asset: Asset = try await Asset(url: metadata.url)
        self.attachment = Attachment(asset: asset)
        self.metadata = metadata
    }
    
    // MARK: Identifiable
    public var id: String { attachment.asset.id }
    
    // MARK: Equatable
    public static func ==(lhs: Item, rhs: Item) -> Bool {
        lhs.id == rhs.id
    }
}

extension Item: Encodable {
    
    // MARK: Encodable
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        try container.encode(title, forKey: .title)
        try container.encode(summary, forKey: .summary)
        try container.encode(URL(string: image.relativePath, relativeTo: try encoder.url())!, forKey: .image)
        try container.encode(metadata.published, forKey: .datePublished)
        try container.encode([attachment], forKey: .attachments)
        if metadata.isExplicit {
            try container.encode([Key.explicit.stringValue], forKey: .tags)
        }
        try container.encode(id, forKey: .id)
    }
}

extension Item.Metadata: Decodable {
    
    // MARK: Decodable
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Key> = try decoder.container(keyedBy: Key.self)
        published = try container.decode(Date.self, forKey: .datePublished)
        isExplicit = (try? container.decode([String].self, forKey: .tags))?.contains(Key.explicit.stringValue) ?? false
        guard let attachment: Attachment = (try container.decode([Attachment].self, forKey: .attachments)).first,
        let url: URL = URL(string: attachment.url.lastPathComponent, relativeTo: try decoder.url()) else {
            throw DecodingError.valueNotFound(Attachment.self, DecodingError.Context(codingPath: [], debugDescription: ""))
        }
        self.url = url
    }
    
    private struct Attachment: Decodable {
        let url: URL
    }
}

private enum Key: String, CodingKey {
    case title, summary, image, attachments, tags, explicit, id
    case datePublished = "date_published"
}
