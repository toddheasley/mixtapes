import Foundation
import AVFoundation

extension AVAsset {
    func chapterMetadataGroups() -> [AVMetadataGroup] {
        return chapterMetadataGroups(bestMatchingPreferredLanguages: availableChapterLocales.map { $0.identifier })
    }
    
    var artwork: Data? {
        return metadataItem("artwork")?.dataValue
    }
    
    var artist: String? {
        return metadataItem("artist")?.stringValue
    }
    
    var title: String? {
        return metadataItem("title")?.stringValue
    }
    
    func metadataItem(_ key: String) -> AVMetadataItem? {
        for metadataItem in commonMetadata {
            guard metadataItem.commonKey?.rawValue == key else {
                continue
            }
            return metadataItem
        }
        return nil
    }
}
