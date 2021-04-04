import XCTest
@testable import Mixtapes

final class StringTests: XCTestCase {
    
}

extension StringTests {
    func testLeftPadded() {
        XCTAssertEqual("|".leftPadded(to: 0, with: "+"), "")
        XCTAssertEqual("|".leftPadded(to: -1, with: "+"), "")
        XCTAssertEqual("|".leftPadded(to: 1, with: "+"), "|")
        XCTAssertEqual("|".leftPadded(to: 8, with: "+"), "+++++++|")
        XCTAssertEqual("|".leftPadded(to: 8), "       |")
    }
}
