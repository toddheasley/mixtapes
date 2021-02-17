import Foundation
import AVFoundation

public struct Asset: Identifiable {
    public let url: URL
    public let length: Int
    public let mimeType: String
    public let duration: TimeInterval
    public let chapters: [Chapter]
    public let artwork: Artwork
    public let artist: String
    public let title: String
    
    public init(url: URL) throws {
        self.url = url
        guard let length: Int = url.fileSize else {
            throw Error("Asset not found", url: url)
        }
        self.length = length
        switch url.contentType {
        case UTType("com.apple.m4a-audio"):
            mimeType = "audio/x-m4a"
        case UTType.mp3:
            mimeType = "audio/mpeg"
        default:
            throw Error("Asset not AAC or MP3", url: url)
        }
        let asset: AVAsset = AVAsset(url: url)
        duration = asset.duration.seconds
        let chapters: [Chapter] = try asset.chapterMetadataGroups().map { group in
            return try Chapter(metadata: group.items)
        }
        self.chapters = chapters.count > 1 ? chapters : []
        self.artwork = try Artwork(asset.artwork, url: url)
        guard let artist: String = asset.artist, !artist.isEmpty else {
            throw Error("Asset artist not found", url: url)
        }
        self.artist = artist
        guard let title: String = asset.title, !title.isEmpty else {
            throw Error("Asset title not found", url: url)
        }
        self.title = title
        guard let id: String = url.id else {
            throw Error("Asset ID not found", url: url)
        }
        self.id = id
    }
    
    // MARK: Identifiable
    public let id: String
}
