import XCTest
@testable import Mixtapes

final class IconTests: XCTestCase {
    func testReset() throws {
        let icon: Icon = try Icon(url: resource("example.m4a"))
        XCTAssertEqual(icon.url.relativePath, "icon.png")
        XCTAssertEqual(icon.data.count, 1326)
        XCTAssertNoThrow(try icon.reset(try! Data(contentsOf: resource("example.png"))))
        XCTAssertEqual(icon.url.relativePath, "icon.png")
        XCTAssertEqual(icon.data.count, 1333)
        XCTAssertThrowsError(try icon.reset(try! Data(contentsOf: resource("example.gif"))))
        XCTAssertEqual(icon.url.relativePath, "icon.png")
        XCTAssertEqual(icon.data.count, 1333)
        XCTAssertNoThrow(try icon.reset(try! Data(contentsOf: resource("example.jpg"))))
        XCTAssertEqual(icon.url.relativePath, "icon.jpg")
        XCTAssertEqual(icon.data.count, 3897)
        XCTAssertNoThrow(try icon.reset())
        XCTAssertEqual(icon.url.relativePath, "icon.png")
        XCTAssertEqual(icon.data.count, 1326)
    }
    
    func testURLInit() throws {
        let url: URL = resource("example.m4a")
        XCTAssertEqual(try Icon(url: url, path: "example.jpg").url.relativePath, "icon.jpg")
        XCTAssertEqual(try Icon(url: url, path: "example.jpg").data.count, 3897)
        XCTAssertEqual(try Icon(url: url, path: "example.gif").url.relativePath, "icon.png")
        XCTAssertEqual(try Icon(url: url, path: "example.gif").data.count, 1326)
        XCTAssertEqual(try Icon(url: url, path: "example.foo").url.relativePath, "icon.png")
        XCTAssertEqual(try Icon(url: url, path: "example.foo").data.count, 1326)
        XCTAssertEqual(try Icon(url: url).url.relativePath, "icon.png")
        XCTAssertEqual(try Icon(url: url).data.count, 1326)
    }
}
