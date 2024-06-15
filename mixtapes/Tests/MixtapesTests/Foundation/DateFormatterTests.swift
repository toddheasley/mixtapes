import Testing
@testable import Mixtapes
import Foundation

struct DateFormatterTests {
    @Test func rfc3339() {
        let dateFormatter: DateFormatter = .rfc3339
        #expect(dateFormatter.string(from: Date(timeIntervalSince1970: 0.0)) == "1970-01-01T00:00:00Z")
        #expect(dateFormatter.dateFormat == "yyyy-MM-dd'T'HH:mm:ssZZZZZ")
        #expect(dateFormatter.locale.identifier == "en_US_POSIX")
        #expect(dateFormatter.timeZone.secondsFromGMT() == 0)
    }
    
    @Test func rfc822() {
        let dateFormatter: DateFormatter = .rfc822
        #expect(dateFormatter.string(from: Date(timeIntervalSince1970: 0.0)) == "Thu, 1 Jan 1970 00:00:00 GMT")
        #expect(dateFormatter.dateFormat == "EEE, d MMM yyyy HH:mm:ss zzz")
        #expect(dateFormatter.locale.identifier == "en_US_POSIX")
        #expect(dateFormatter.timeZone.secondsFromGMT() == 0)
    }
}
