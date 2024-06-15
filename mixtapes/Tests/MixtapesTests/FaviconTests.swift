import Testing
@testable import Mixtapes

struct FaviconTests {
    @Test func iconInit() throws {
        let favicon: Favicon = try Favicon(url: resources)
        #expect(favicon.url.relativePath == "favicon.ico")
        #expect(favicon.data.count == 2041)
    }
}
