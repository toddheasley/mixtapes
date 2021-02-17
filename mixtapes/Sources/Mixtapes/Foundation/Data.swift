import Foundation

extension Data {
    var pathExtension: String? {
        switch first {
        case 0x89:
            return "png"
        case 0xFF:
            return "jpg"
        default:
            return nil
        }
    }
}
