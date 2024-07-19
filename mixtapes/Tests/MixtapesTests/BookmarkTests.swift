import Testing
@testable import Mixtapes
import AppKit

struct BookmarkTests {
    @Test func iconInit() throws {
        let bookmark: Bookmark = try Bookmark(icon: Icon(url: resources))
        let url: URL = try Icon(url: resources).url
        #expect(bookmark.url == URL(string: "apple-touch-icon.png", relativeTo: url))
        #expect(NSImage(data: bookmark.data)?.size == CGSize(width: 256.0, height: 256.0))
    }
}
