import Foundation
import AVFoundation

public struct Asset {
    public enum Error: Swift.Error {
        case assetNotFound, artworkNotFound, artworkNotJPEG, artistNotFound, titleNotFound
    }
    
    public private(set) var url: URL
    public private(set) var length: Int
    public private(set) var duration: TimeInterval
    public private(set) var chapters: [Chapter]
    public private(set) var artwork: Resource
    public private(set) var artist: String = ""
    public private(set) var title: String = ""
    
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
        chapters = try asset.chapterMetadataGroups(bestMatchingPreferredLanguages: asset.availableChapterLocales.map { locale in
            return locale.identifier
        }).map { group in
            return try Chapter(metadata: group.items)
        }
        chapters = chapters.count > 1 ? chapters : []
        artwork = Resource(url: URL(fileURLWithPath: self.url.relativePath.replacingOccurrences(of: ".m4a", with: ".jpg"), relativeTo: self.url.baseURL!))
        for metadataItem: AVMetadataItem in asset.commonMetadata {
            switch metadataItem.commonKey!.rawValue {
            case "artwork":
                guard metadataItem.dataType == "com.apple.metadata.datatype.JPEG" else {
                    throw Error.artworkNotJPEG
                }
                artwork = Resource(url: artwork.url, data: metadataItem.dataValue ?? Data())
            case "artist":
                artist = metadataItem.stringValue ?? ""
            case "title":
                title = metadataItem.stringValue ?? ""
            default:
                break
            }
        }
        guard !artwork.isEmpty else {
            throw Error.artworkNotFound
        }
        guard !artist.isEmpty else {
            throw Error.artistNotFound
        }
        guard !title.isEmpty else {
            throw Error.titleNotFound
        }
    }
}
