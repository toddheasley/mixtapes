import XCTest
@testable import Mixtapes

final class AuthorTests: XCTestCase {
    
    // MARK: CustomStringConvertible
    func testDescription() {
        XCTAssertEqual(Author("Todd Heasley", url: "mailto:toddheasley@me.com").description, "Todd Heasley")
        XCTAssertEqual(Author(url: "mailto:toddheasley@me.com").description, "mailto:toddheasley@me.com")
    }
}
