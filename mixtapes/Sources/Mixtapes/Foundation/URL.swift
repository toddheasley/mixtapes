import Foundation
import AVFoundation

extension URL {
    var fileSize: Int? {
        return try? resourceValues(forKeys: [.fileSizeKey]).fileSize
    }
    
    var contentType: UTType? {
        return try? resourceValues(forKeys: [.contentTypeKey]).contentType
    }
    
    var id: String? {
        guard let id: String = lastPathComponent.components(separatedBy: ".").first, !id.isEmpty else {
            return nil
        }
        return id
    }
}
