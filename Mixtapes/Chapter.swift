import Foundation
import AVFoundation

public struct Chapter {
    public enum Error: Swift.Error {
        case titleNotFound
    }
    
    public private(set) var duration: ClosedRange<TimeInterval> = 0.0...0.0
    public private(set) var title: String = ""
    
    init(metadata: [AVMetadataItem]) throws {
        for metadataItem in metadata {
            guard metadataItem.commonKey?.rawValue == "title" else {
                continue
            }
            duration = max(metadataItem.time.seconds.rounded(.down), 0.0)...(metadataItem.time.seconds + metadataItem.duration.seconds).rounded(.down)
            title = metadataItem.stringValue ?? ""
            break
        }
        guard !title.isEmpty else {
            throw Error.titleNotFound
        }
    }
}
