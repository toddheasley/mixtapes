import Foundation
import Mixtapes

extension CommandLine {
    enum Result {
        case failure(Error), finished
    }
    
    static func print(_ result: Result) {
        switch result {
        case .failure(let error):
            Swift.print("\(Bundle.main.executableName) failure: \(error)")
        case .finished:
            Swift.print("\(Bundle.main.executableName) finished")
        }
    }
}

extension CommandLine {
    static var currentDirectoryURL: URL {
        return URL(fileURLWithPath: FileManager.default.currentDirectoryPath, isDirectory: true)
    }
}
