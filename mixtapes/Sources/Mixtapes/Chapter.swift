import Foundation
import AVFoundation

public struct Chapter {
    public let duration: ClosedRange<TimeInterval>?
    public let title: String
    
    init(metadata: [AVMetadataItem]) throws {
        var duration: ClosedRange<TimeInterval>?
        var title: String = ""
        for metadataItem in metadata {
            guard metadataItem.commonKey?.rawValue == "title" else {
                continue
            }
            if metadataItem.time.seconds >= 0.0, metadataItem.duration.seconds >= 0.0 {
                duration = max(metadataItem.time.seconds, 0.0)...(metadataItem.time.seconds + metadataItem.duration.seconds)
            }
            title = metadataItem.stringValue ?? title
            break
        }
        guard !title.isEmpty else {
            throw Error("Chapter title not found")
        }
        self.duration = duration
        self.title = title
    }
}