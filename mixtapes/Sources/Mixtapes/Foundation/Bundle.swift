import Foundation

extension Bundle {
    func resource(_ path: String) throws -> Data {
        try Data(contentsOf: resourceURL!.appendingPathComponent("\(path)"))
    }
}
