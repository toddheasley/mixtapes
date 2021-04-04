import XCTest
@testable import Mixtapes

final class ArtworkTests: XCTestCase {
    func testDataInit() throws {
        let url: URL = resources.appendingPathComponent("example")
        XCTAssertEqual(try Artwork(try Data(contentsOf: resource("example.png")), url: url).url, URL(fileURLWithPath: "example.png", relativeTo: url))
        XCTAssertThrowsError(try Artwork(try Data(contentsOf: resource("example.gif")), url: url))
        XCTAssertEqual(try Artwork(try Data(contentsOf: resource("example.jpg")), url: url).url, URL(fileURLWithPath: "example.jpg", relativeTo: url))
        XCTAssertThrowsError(try Artwork(nil, url: url))
    }
}
