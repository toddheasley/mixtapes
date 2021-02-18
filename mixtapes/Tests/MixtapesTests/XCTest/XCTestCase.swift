import XCTest

extension XCTestCase {
    var resources: URL {
        return URL(string: Bundle.module.resourceURL!.appendingPathComponent("Resources").absoluteString)!
    }
    
    func resource(_ path: String) -> URL {
        return URL(fileURLWithPath: path, relativeTo: resources)
    }
}
