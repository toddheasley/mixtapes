import Foundation

public struct Item {
    public let attachment: Attachment
    public var date: (published: Date, modified: Date?) = (Date(), nil)
    public var isExplicit: Bool
    
    public var id: String {
        return attachment.asset.id
    }
    
    public var title: String {
        return attachment.asset.title
    }
    
    public var summary: String {
        return attachment.asset.artist
    }
    
    public var image: URL {
        return attachment.asset.artwork.url
    }
    
    public init(asset: Asset, published date: Date? = nil, explicit: Bool = false) {
        self.attachment = Attachment(asset: asset)
        if let date: Date = date {
            self.date.published = date
        }
        self.isExplicit = explicit
    }
}

extension Item: Codable {
    
    // MARK: Codable
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Key> = try decoder.container(keyedBy: Key.self)
        guard let attachment: Attachment = (try container.decode([Attachment].self, forKey: .attachments)).first else {
            throw DecodingError.valueNotFound(Attachment.self, DecodingError.Context(codingPath: [], debugDescription: ""))
        }
        self.attachment = attachment
        date.published = try container.decode(Date.self, forKey: .datePublished)
        date.modified = try? container.decode(Date.self, forKey: .dateModified)
        isExplicit = (try? container.decode([String].self, forKey: .tags))?.contains(Key.explicit.stringValue) ?? false
    }
    
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(summary, forKey: .summary)
        try container.encode(URL(string: image.relativePath, relativeTo: try encoder.url())!, forKey: .image)
        try container.encode(date.published, forKey: .datePublished)
        if let modified: Date = date.modified {
            try container.encode(modified, forKey: .dateModified)
        }
        try container.encode([attachment], forKey: .attachments)
        if isExplicit {
            try container.encode([Key.explicit.stringValue], forKey: .tags)
        }
    }
    
    private enum Key: String, CodingKey {
        case id, title, summary, image, datePublished = "date_published", dateModified = "date_modified", attachments, tags, explicit
    }
}
