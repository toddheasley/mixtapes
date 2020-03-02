import XCTest
@testable import Mixtapes

final class TimeIntervalTests: XCTestCase {
    
}

extension TimeIntervalTests {
    
    // MARK: CustomStringConvertible
    func testDescription() {
        XCTAssertEqual(1574.0.description, "26:14")
        XCTAssertEqual(421.0.description, "7:01")
        XCTAssertEqual(32045.0.description, "8:54:05")
        XCTAssertEqual(7297.0.description, "2:01:37")
        XCTAssertEqual(0.0.description, "0:00")
    }
}
