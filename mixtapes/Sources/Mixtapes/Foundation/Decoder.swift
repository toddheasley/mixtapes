import Foundation

extension Decoder {
    func url() throws -> URL {
        guard let url: URL = userInfo[.url] as? URL else {
            throw DecodingError.valueNotFound(URL.self, DecodingError.Context(codingPath: [], debugDescription: ""))
        }
        return url
    }
}

extension JSONDecoder {
    convenience init(url: URL) {
        self.init()
        dateDecodingStrategy = .formatted(.rfc3339)
        userInfo[.url] = url
    }
}
