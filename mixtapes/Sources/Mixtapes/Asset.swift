import AVFoundation

public struct Asset: Identifiable {
    public static let contentTypes: [UTType] = [.m4a, .mp3]
    
    public let url: URL
    public let length: Int
    public let mimeType: String
    public let duration: TimeInterval
    public let chapters: [Chapter]
    public let artwork: Artwork
    public let artist: String
    public let title: String
    
    public init(url: URL) async throws {
        self.url = url
        guard let length: Int = url.fileSize else {
            throw Error("Asset not found", url: url)
        }
        self.length = length
        switch url.contentType {
        case Self.contentTypes[0]:
            mimeType = "audio/x-m4a"
        case Self.contentTypes[1]:
            mimeType = "audio/mpeg"
        default:
            throw Error("Asset not AAC or MP3", url: url)
        }
        let asset: AVAsset = AVAsset(url: url)
        duration = try await asset.duration()
        var chapters: [Chapter] = []
        let groups: [AVMetadataGroup] = try await asset.chapterMetadataGroups()
        for (i, group) in groups.enumerated() {
            await chapters.append(try Chapter(id: "\(i + 1)", metadata: group.items))
        }
        self.chapters = chapters.count > 1 ? chapters : []
        let data: Data = try await asset.artwork()
        self.artwork = try Artwork(data, url: url)
        self.artist = try await asset.artist()
        self.title = try await asset.title()
        guard let id: String = url.id else {
            throw Error("Asset ID not found", url: url)
        }
        self.id = id
    }
    
    // MARK: Identifiable
    public let id: String
}
