import XCTest
@testable import Mixtapes

final class IconTests: XCTestCase {
    func testIsDefault() throws {
        let url: URL = resource("example.m4a")
        XCTAssertFalse(try Icon(url: url, path: "example.png").isDefault)
        XCTAssertFalse(try Icon(url: url, path: "example.jpg").isDefault)
        XCTAssertTrue(try Icon(url: url).isDefault)
    }
    
    func testData() {
        XCTAssertEqual(Icon.data.count, 247426)
    }
    
    func testReset() throws {
        var icon: Icon = try Icon(url: resource("example.m4a"))
        XCTAssertEqual(icon.url.relativePath, "icon.png")
        XCTAssertEqual(icon.data.count, 247426)
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
        XCTAssertEqual(icon.data.count, 247426)
    }
    
    func testURLInit() throws {
        let url: URL = resource("example.m4a")
        XCTAssertEqual(try Icon(url: url, path: "example.jpg").url.relativePath, "icon.jpg")
        XCTAssertEqual(try Icon(url: url, path: "example.jpg").data.count, 3897)
        XCTAssertEqual(try Icon(url: url, path: "example.gif").url.relativePath, "icon.png")
        XCTAssertEqual(try Icon(url: url, path: "example.gif").data.count, 247426)
        XCTAssertEqual(try Icon(url: url, path: "example.foo").url.relativePath, "icon.png")
        XCTAssertEqual(try Icon(url: url, path: "example.foo").data.count, 247426)
        XCTAssertEqual(try Icon(url: url).url.relativePath, "icon.png")
        XCTAssertEqual(try Icon(url: url).data.count, 247426)
    }
}
