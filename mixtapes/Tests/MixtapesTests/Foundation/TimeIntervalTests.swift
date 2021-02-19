import XCTest
@testable import Mixtapes

final class TimeIntervalTests: XCTestCase {
    
}

extension TimeIntervalTests {
    func testTimestamp() {
        XCTAssertEqual(1574.5.timestamp, "26:14")
        XCTAssertEqual(421.9.timestamp, "7:01")
        XCTAssertEqual(32045.0.timestamp, "8:54:05")
        XCTAssertEqual(7297.1.timestamp, "2:01:37")
        XCTAssertEqual(0.0.timestamp, "0:00")
    }
}
