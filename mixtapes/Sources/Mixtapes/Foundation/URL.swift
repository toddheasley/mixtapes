import Foundation
import AVFoundation

extension URL {
    public init?(homepage: String, path: String = "") {
        guard var components: URLComponents = URLComponents(string: homepage),
              ["http", "https", nil].contains(components.scheme),
              components.host != nil else {
            return nil
        }
        components.scheme = components.scheme ?? "http"
        components.fragment = nil
        components.query = nil
        guard var url: URL = components.url else {
            return nil
        }
        if !url.pathExtension.isEmpty {
            url.deleteLastPathComponent()
        }
        if !url.hasDirectoryPath {
            url.appendPathComponent("")
        }
        self = URL(string: path, relativeTo: url) ?? url
    }
    
    var fileSize: Int? { try? resourceValues(forKeys: [.fileSizeKey]).fileSize }
    
    var contentType: UTType? { try? resourceValues(forKeys: [.contentTypeKey]).contentType }
    
    var id: String? {
        guard let id: String = lastPathComponent.components(separatedBy: ".").first,
              !id.isEmpty else {
            return nil
        }
        return id
    }
}
