import Foundation

extension Bundle {
    var executableName: String {
        return executableURL!.lastPathComponent
    }
}
