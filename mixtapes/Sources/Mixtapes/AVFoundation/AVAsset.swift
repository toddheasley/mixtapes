import Foundation
import AVFoundation

extension AVAsset {
    func chapterMetadataGroups() -> [AVMetadataGroup] {
        return chapterMetadataGroups(bestMatchingPreferredLanguages: availableChapterLocales.map { $0.identifier })
    }
    
    var artwork: (data: Data, dataType: String)? {
        guard let metadataItem: AVMetadataItem = metadataItem("artwork"),
              let data: Data = metadataItem.dataValue,
              let dataType: String = metadataItem.dataType else {
            return nil
        }
        return (data, dataType)
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
