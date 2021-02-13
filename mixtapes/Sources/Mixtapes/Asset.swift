import Foundation
import AVFoundation

public struct Asset: Identifiable {
    public let url: URL
    public let length: Int
    public let mimeType: String
    public let duration: TimeInterval
    public let chapters: [Chapter]
    public let artwork: Resource
    public let artist: String
    public let title: String
    
    public init(url: URL) throws {
        self.url = url
        self.length = try Self.length(url)
        self.mimeType = try Self.mimeType(url)
        self.id = try Self.id(url)
        let asset: AVAsset = AVAsset(url: url)
        duration = asset.duration.seconds
        let chapters: [Chapter] = try asset.chapterMetadataGroups().map { group in
            return try Chapter(metadata: group.items)
        }
        self.chapters = chapters.count > 1 ? chapters : []
        guard let artwork: (data: Data, dataType: String) = asset.artwork else {
            throw Error("Asset artwork not found", url: url)
        }
        switch artwork.dataType {
        case "com.apple.metadata.datatype.PNG":
            self.artwork = Resource(url: URL(fileURLWithPath: url.relativePath.replacingOccurrences(of: url.pathExtension, with: "png"), relativeTo: url.baseURL), data: artwork.data)
        case "com.apple.metadata.datatype.JPEG":
            self.artwork = Resource(url: URL(fileURLWithPath: url.relativePath.replacingOccurrences(of: url.pathExtension, with: "jpg"), relativeTo: url.baseURL), data: artwork.data)
        default:
            throw Error("Asset artwork not JPEG or PNG", url: url)
        }
        guard let artist: String = asset.artist, !artist.isEmpty else {
            throw Error("Asset artist not found", url: url)
        }
        self.artist = artist
        guard let title: String = asset.title, !title.isEmpty else {
            throw Error("Asset title not found", url: url)
        }
        self.title = title
    }
    
    static func length(_ url: URL) throws -> Int {
        guard let length: Int = try url.resourceValues(forKeys: [.fileSizeKey]).fileSize, length > 0 else {
            throw Error("Asset not found", url: url)
        }
        return length
    }
    
    static func mimeType(_ url: URL) throws -> String {
        switch url.pathExtension {
        case "m4a":
            return "audio/x-m4a"
        case "mp3":
            return "audio/mpeg"
        default:
            throw Error("Asset type not AAC or MP3", url: url)
        }
    }
    
    static func id(_ url: URL) throws -> String {
        guard let id: String = url.lastPathComponent.components(separatedBy: ".").first, !id.isEmpty else {
            throw Error("Asset ID not found", url: url)
        }
        return id
    }
    
    // MARK: Identifiable
    public let id: String
}
