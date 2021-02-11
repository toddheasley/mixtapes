import XCTest
@testable import Mixtapes

final class DurationTests: XCTestCase {
    func testTimeIntervalInit() {
        XCTAssertEqual(Duration(seconds: 1547.9).seconds, 1547)
        XCTAssertEqual(Duration(seconds: -77.0).seconds, 0)
    }
    
    // MARK: CustomStringConvertible
    func testDescription() {
        XCTAssertEqual(Duration(seconds: 1574.0).description, "26:14")
        XCTAssertEqual(Duration(seconds: 421.0).description, "7:01")
        XCTAssertEqual(Duration(seconds: 32045.0).description, "8:54:05")
        XCTAssertEqual(Duration(seconds: 7297.0).description, "2:01:37")
        XCTAssertEqual(Duration(seconds: 0.0).description, "0:00")
    }
}
