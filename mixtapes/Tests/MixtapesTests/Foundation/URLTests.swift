import XCTest
import AVFoundation
@testable import Mixtapes

final class URLTests: XCTestCase {
    
}

extension URLTests {
    func testFileSize() {
        XCTAssertNil(Bundle.module.resourceURL!.fileSize)
        XCTAssertNil(URL(string: "https://example.com")!.fileSize)
        XCTAssertEqual(resource("example.m4a").fileSize, 738675)
        XCTAssertEqual(resource("example.mp3").fileSize, 738325)
        XCTAssertEqual(resource("example.png").fileSize, 1333)
        XCTAssertEqual(resource("example.gif").fileSize, 1290)
        XCTAssertEqual(resource("example.jpg").fileSize, 3897)
    }
    
    func testContentType() {
        XCTAssertNil(URL(string: "https://example.com")!.contentType)
        XCTAssertEqual(resource("example.m4a").contentType, UTType("com.apple.m4a-audio"))
        XCTAssertEqual(resource("example.mp3").contentType, .mp3)
        XCTAssertEqual(resource("example.png").contentType, .png)
        XCTAssertEqual(resource("example.gif").contentType, .gif)
        XCTAssertEqual(resource("example.jpg").contentType, .jpeg)
    }
    
    func testID() {
        XCTAssertNil(URL(string: "https://example.com")!.id)
        XCTAssertNil(URL(string: "https://example.com/mixtapes/.mp3")!.id)
        XCTAssertEqual(resource("example.mp3").id, "example")
    }
    
    func testHomepageInit() {
        XCTAssertEqual(URL(homepage: "https://example.com/mixtapes/index.json"), URL(string: "https://example.com/mixtapes/"))
        XCTAssertEqual(URL(homepage: "http://example.com/mixtapes", path: "index.json"), URL(string: "index.json", relativeTo: URL(string: "http://example.com/mixtapes/")))
    }
}
