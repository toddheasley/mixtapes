import XCTest
@testable import Mixtapes

final class BookmarkTests: XCTestCase {
    func testIconInit() throws {
        let bookmark: Bookmark = try Bookmark(icon: Icon(url: resources))
        XCTAssertEqual(bookmark.url, URL(string: "apple-touch-icon.png", relativeTo: try Icon(url: resources).url))
        XCTAssertEqual(NSImage(data: bookmark.data)?.size, CGSize(width: 152.0, height: 152.0))
    }
}
