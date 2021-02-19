import XCTest
@testable import Mixtapes

final class BundleTests: XCTestCase {
    
}

extension BundleTests {
    func testResource() throws {
        XCTAssertEqual(try Bundle.module.resource("example.png").count, 1333)
        XCTAssertThrowsError(try Bundle.module.resource("example.foo"))
    }
}
