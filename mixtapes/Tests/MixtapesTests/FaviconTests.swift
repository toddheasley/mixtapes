import XCTest
@testable import Mixtapes

final class FaviconTests: XCTestCase {
    func testIconInit() throws {
        let favicon: Favicon = try Favicon(url: resources)
        XCTAssertEqual(favicon.url.relativePath, "favicon.ico")
        XCTAssertEqual(favicon.data.count, 2041)
    }
}
