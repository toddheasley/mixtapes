import XCTest
import AVFoundation
@testable import Mixtapes

final class URLTests: XCTestCase {
    
}

extension URLTests {
    func testFileSize() {
        XCTAssertNil(Bundle.module.resourceURL!.fileSize)
        XCTAssertNil(URL(string: "https://example.com")!.fileSize)
        XCTAssertEqual(example(.m4a).fileSize, 738675)
        XCTAssertEqual(example(.mp3).fileSize, 738325)
        XCTAssertEqual(example(.png).fileSize, 1333)
        XCTAssertEqual(example(.gif).fileSize, 1290)
        XCTAssertEqual(example(.jpg).fileSize, 3897)
    }
    
    func testContentType() {
        XCTAssertNil(URL(string: "https://example.com")!.contentType)
        XCTAssertEqual(example(.m4a).contentType, UTType("com.apple.m4a-audio"))
        XCTAssertEqual(example(.mp3).contentType, .mp3)
        XCTAssertEqual(example(.png).contentType, .png)
        XCTAssertEqual(example(.gif).contentType, .gif)
        XCTAssertEqual(example(.jpg).contentType, .jpeg)
    }
    
    func testID() {
        XCTAssertNil(URL(string: "https://example.com")!.id)
        XCTAssertNil(URL(string: "https://example.com/mixtapes/.mp3")!.id)
        XCTAssertEqual(example(.mp3).id, "example")
    }
}
