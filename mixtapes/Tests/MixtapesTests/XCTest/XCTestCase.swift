import XCTest

extension XCTestCase {
    var resources: URL {
        return Bundle.module.resourceURL!
    }
    
    func resource(_ path: String) -> URL {
        return URL(fileURLWithPath: path, relativeTo: resources)
    }
}
