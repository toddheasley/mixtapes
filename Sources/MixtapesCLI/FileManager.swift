import Foundation
import Mixtapes

extension FileManager {
    var currentDirectoryURL: URL {
        return URL(fileURLWithPath: currentDirectoryPath, isDirectory: true)
    }
    
    func index(directory url: URL? = nil, filter: String? = nil) -> [URL] {
        guard let enumerator: FileManager.DirectoryEnumerator = enumerator(at: url ?? currentDirectoryURL, includingPropertiesForKeys: nil) else {
            return []
        }
        let filter: String = filter ?? ""
        var urls: [URL] = []
        while let url: URL = enumerator.nextObject() as? URL {
            guard filter.isEmpty || url.lastPathComponent.contains(filter) else {
                continue
            }
            urls.append(url)
        }
        return urls
    }
}
