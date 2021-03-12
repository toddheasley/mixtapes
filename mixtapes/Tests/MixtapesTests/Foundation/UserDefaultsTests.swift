import XCTest
@testable import Mixtapes

final class UserDefaultsTests: XCTestCase {
    
}

extension UserDefaultsTests {
    func testURL() {
        UserDefaults.standard.url = URL(fileURLWithPath: "/Users/toddheasley/Documents/")
        XCTAssertEqual(UserDefaults.standard.url, URL(fileURLWithPath: "/Users/toddheasley/Documents/"))
        UserDefaults.standard.url = nil
        XCTAssertNil(UserDefaults.standard.url)
    }
}
