import XCTest
@testable import Mixtapes

final class FaviconTests: XCTestCase {
    func testIconInit() throws {
        let favicon: Favicon = try Favicon(icon: Icon(url: resources))
        XCTAssertEqual(favicon.url, URL(string: "favicon.ico", relativeTo: try Icon(url: resources).url))
        XCTAssertEqual(UIImage(data: favicon.data)?.size, CGSize(width: 64.0, height: 64.0))
    }
}
