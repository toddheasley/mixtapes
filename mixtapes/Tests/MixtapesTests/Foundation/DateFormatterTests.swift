import XCTest
@testable import Mixtapes

final class DateFormatterTests: XCTestCase {
    
}

extension DateFormatterTests {
    func testRFC3339() {
        let dateFormatter: DateFormatter = .rfc3339
        XCTAssertEqual(dateFormatter.string(from: Date(timeIntervalSince1970: 0.0)), "1970-01-01T00:00:00Z")
        XCTAssertEqual(dateFormatter.dateFormat, "yyyy-MM-dd'T'HH:mm:ssZZZZZ")
        XCTAssertEqual(dateFormatter.locale.identifier, "en_US_POSIX")
        XCTAssertEqual(dateFormatter.timeZone.secondsFromGMT(), 0)
    }
    
    func testRFC822() {
        let dateFormatter: DateFormatter = .rfc822
        XCTAssertEqual(dateFormatter.string(from: Date(timeIntervalSince1970: 0.0)), "Thu, 1 Jan 1970 00:00:00 GMT")
        XCTAssertEqual(dateFormatter.dateFormat, "EEE, d MMM yyyy HH:mm:ss zzz")
        XCTAssertEqual(dateFormatter.locale.identifier, "en_US_POSIX")
        XCTAssertEqual(dateFormatter.timeZone.secondsFromGMT(), 0)
    }
}
