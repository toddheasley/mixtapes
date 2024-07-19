import Testing
@testable import Mixtapes
import Foundation

struct TimeIntervalTests {
    @Test func timestamp() {
        #expect(1574.5.timestamp == "26:14")
        #expect(421.9.timestamp == "7:01")
        #expect(32045.0.timestamp == "8:54:05")
        #expect(7297.1.timestamp == "2:01:37")
        #expect(0.0.timestamp == "0:00")
    }
}
