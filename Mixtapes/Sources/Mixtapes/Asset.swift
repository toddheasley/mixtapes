import Foundation
import AVFoundation

public struct Asset {
    public enum Error: Swift.Error {
        case assetNotFound, artworkNotFound, artworkNotJPEG, artistNotFound, titleNotFound
    }
    
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
            throw Error.assetNotFound
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
                    throw Error.artworkNotJPEG
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
            throw Error.artworkNotFound
        }
        self.artwork = artwork
        guard !artist.isEmpty else {
            throw Error.artistNotFound
        }
        self.artist = artist
        guard !title.isEmpty else {
            throw Error.titleNotFound
        }
        self.title = title
    }
}
