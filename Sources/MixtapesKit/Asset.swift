import Foundation
import AVFoundation

public struct Asset {
    public let url: URL
    public let length: Int
    public let duration: TimeInterval
    public let chapters: [Chapter]
    public let artwork: Resource
    public let artist: String
    public let title: String
    
    public var id: String {
        return url.lastPathComponent.components(separatedBy: ".").first!
    }
    
    public var mimeType: String {
        return "audio/x-m4a"
    }
    
    public init(url: URL) throws {
        self.url = url
        guard let length: Int = try url.resourceValues(forKeys: [.fileSizeKey]).fileSize, length > 0 else {
            throw Error("asset not found", url: url)
        }
        self.length = length
        let asset: AVAsset = AVAsset(url: url)
        duration = asset.duration.seconds.rounded(.down)
        let chapters: [Chapter] = try asset.chapterMetadataGroups(bestMatchingPreferredLanguages: asset.availableChapterLocales.map { locale in
            return locale.identifier
        }).map { group in
            return try Chapter(metadata: group.items)
        }
        self.chapters = chapters.count > 1 ? chapters : []
        var artwork: Resource = Resource(url: URL(fileURLWithPath: self.url.relativePath.replacingOccurrences(of: ".m4a", with: ".jpg"), relativeTo: self.url.baseURL!))
        var artist: String = ""
        var title: String = ""
        for metadataItem: AVMetadataItem in asset.commonMetadata {
            switch metadataItem.commonKey!.rawValue {
            case "artwork":
                guard metadataItem.dataType == "com.apple.metadata.datatype.JPEG" else {
                    throw Error("asset artwork not jpeg", url: url)
                }
                artwork = Resource(url: artwork.url, data: metadataItem.dataValue ?? Data())
            case "artist":
                artist = metadataItem.stringValue ?? artist
            case "title":
                title = metadataItem.stringValue ?? title
            default:
                break
            }
        }
        guard !artwork.isEmpty else {
            throw Error("asset artwork not found", url: url)
        }
        self.artwork = artwork
        guard !artist.isEmpty else {
            throw Error("asset artist not found", url: url)
        }
        self.artist = artist
        guard !title.isEmpty else {
            throw Error("asset title not found", url: url)
        }
        self.title = title
    }
}