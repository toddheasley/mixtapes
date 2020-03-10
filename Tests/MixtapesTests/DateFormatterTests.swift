import XCTest
@testable import Mixtapes

final class DateFormatterTests: XCTestCase {
    
}

extension DateFormatterTests {
    func testFormat() {
        XCTAssertEqual(DateFormatter.Format.rfc3339.rawValue, "yyyy-MM-dd'T'HH:mm:ssZZZZZ")
        XCTAssertEqual(DateFormatter.Format.rfc822.rawValue, "EEE, d MMM yyyy HH:mm:ss zzz")
    }
    
    func testFormatInit() {
        let date: Date = Date(timeIntervalSince1970: 0.0)
        XCTAssertEqual(DateFormatter(format: .rfc3339).locale.identifier, "en_US_POSIX")
        XCTAssertEqual(DateFormatter(format: .rfc3339).timeZone.secondsFromGMT(), 0)
        XCTAssertEqual(DateFormatter(format: .rfc3339).string(from: date), "1970-01-01T00:00:00Z")
        XCTAssertEqual(DateFormatter(format: .rfc822).locale.identifier, "en_US_POSIX")
        XCTAssertEqual(DateFormatter(format: .rfc822).timeZone.secondsFromGMT(), 0)
        XCTAssertEqual(DateFormatter(format: .rfc822).string(from: date), "Thu, 1 Jan 1970 00:00:00 GMT")
    }
}
