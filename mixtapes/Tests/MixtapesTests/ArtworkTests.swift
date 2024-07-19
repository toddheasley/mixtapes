import Testing
@testable import Mixtapes
import Foundation

struct ArtworkTests {
    @Test func dataInit() throws {
        let url: URL = resources.appendingPathComponent("example")
        #expect(try Artwork(try Data(contentsOf: resource("example.png")), url: url).url == URL(fileURLWithPath: "example.png", relativeTo: url))
        #expect(throws: Error.self) {
            try Artwork(try Data(contentsOf: resource("example.gif")), url: url)
        }
        #expect(try Artwork(try Data(contentsOf: resource("example.jpg")), url: url).url == URL(fileURLWithPath: "example.jpg", relativeTo: url))
        #expect(throws: Error.self) {
            try Artwork(nil, url: url)
        }
    }
}
