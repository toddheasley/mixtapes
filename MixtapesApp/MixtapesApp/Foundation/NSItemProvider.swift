import Foundation
import UniformTypeIdentifiers

extension NSItemProvider {
    func fileURL(_ completion: @escaping ((URL?, Error?) -> Void)) {
        loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { data, error in
            DispatchQueue.main.async {
                if let data: Data = data as? Data,
                   let url: URL = URL(dataRepresentation: data, relativeTo: nil, isAbsolute: true) {
                    completion(url, nil)
                } else {
                    completion(nil, error)
                }
            }
        }
    }
}
