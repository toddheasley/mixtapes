import XCTest
@testable import Mixtapes

final class AuthorTests: XCTestCase {
    
    // MARK: CustomStringConvertible
    func testDescription() {
        XCTAssertEqual(Author("mailto:toddheasley@me.com", name: "Todd Heasley").description, "Todd Heasley")
        XCTAssertEqual(Author("mailto:toddheasley@me.com").description, "mailto:toddheasley@me.com")
    }
}
