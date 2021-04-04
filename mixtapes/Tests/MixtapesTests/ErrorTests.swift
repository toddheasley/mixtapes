import XCTest
@testable import Mixtapes

final class ErrorTests: XCTestCase {
    func testDescriptionInit() {
        XCTAssertEqual(Error("Error description", url: URL(string: "https://example.com/path")).description, "Error description: https://example.com/path")
        XCTAssertEqual(Error("Error description", url: URL(fileURLWithPath: "/example/path")).description, "Error description: file:///example/path")
        XCTAssertEqual(Error("Error description", url: nil).description, "Error description")
        XCTAssertEqual(Error("Error description").description, "Error description")
    }
}
