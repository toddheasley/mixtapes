import Foundation
import AVFoundation

public struct Chapter {
    public let duration: ClosedRange<TimeInterval>
    public let title: String
    
    init(metadata: [AVMetadataItem]) throws {
        var duration: ClosedRange<TimeInterval> = 0.0...0.0
        var title: String = ""
        for metadataItem in metadata {
            guard metadataItem.commonKey?.rawValue == "title" else {
                continue
            }
            duration = max(metadataItem.time.seconds.rounded(.down), 0.0)...(metadataItem.time.seconds + metadataItem.duration.seconds).rounded(.down)
            title = metadataItem.stringValue ?? title
            break
        }
        guard !title.isEmpty else {
            throw Error("chapter title not found", url: URL(string: "")!)
        }
        self.duration = duration
        self.title = title
    }
}
