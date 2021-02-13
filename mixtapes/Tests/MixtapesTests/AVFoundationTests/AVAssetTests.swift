import XCTest
import AVFoundation
@testable import Mixtapes

final class AVAssetTests: XCTestCase {
    
}

extension AVAssetTests {
    func testChapterMetadataGroups() throws {
        XCTAssertEqual(AVAsset(url: exampleAAC!).chapterMetadataGroups().count, 5)
        XCTAssertEqual(AVAsset(url: exampleMP3!).chapterMetadataGroups().count, 3)
    }
    
    func testArtwork() {
        XCTAssertEqual(AVAsset(url: exampleAAC!).artwork?.dataType, "com.apple.metadata.datatype.PNG")
        XCTAssertEqual(AVAsset(url: exampleMP3!).artwork?.dataType, "com.apple.metadata.datatype.JPEG")
    }
    
    func testArtist() {
        XCTAssertEqual(AVAsset(url: exampleAAC!).artist, "Artist")
        XCTAssertEqual(AVAsset(url: exampleMP3!).artist, "Artist")
    }
    
    func testTitle() {
        XCTAssertEqual(AVAsset(url: exampleAAC!).title, "Album")
        XCTAssertEqual(AVAsset(url: exampleMP3!).title, "Album")
    }
    
    func testMetadataItem() {
        XCTAssertEqual(AVAsset(url: exampleAAC!).metadataItem("artist")?.stringValue, "Artist")
        XCTAssertEqual(AVAsset(url: exampleMP3!).metadataItem("title")?.stringValue, "Album")
    }
}
