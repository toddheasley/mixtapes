import Foundation

extension Encoder {
    func url() throws -> URL {
        guard let url: URL = userInfo[.url] as? URL else {
            throw EncodingError.invalidValue(URL.self, EncodingError.Context(codingPath: [], debugDescription: ""))
        }
        return url
    }
}

extension JSONEncoder {
    convenience init(url: URL, formatting: OutputFormatting = []) {
        self.init()
        dateEncodingStrategy = .formatted(.rfc3339)
        outputFormatting = formatting
        userInfo[.url] = url
    }
}
