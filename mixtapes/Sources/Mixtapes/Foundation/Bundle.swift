import Foundation

extension Bundle {
    func resource(_ path: String) throws -> Data {
        return try Data(contentsOf: resourceURL!.appendingPathComponent("\(path)"))
    }
}
