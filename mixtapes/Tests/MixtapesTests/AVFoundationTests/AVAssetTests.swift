import XCTest
import AVFoundation
@testable import Mixtapes

final class AVAssetTests: XCTestCase {
    
}

extension AVAssetTests {
    func testChapterMetadataGroups() throws {
        XCTAssertEqual(AVAsset(url: example(.m4a)).chapterMetadataGroups().count, 5)
        XCTAssertEqual(AVAsset(url: example(.mp3)).chapterMetadataGroups().count, 3)
    }
    
    func testArtwork() {
        XCTAssertEqual(AVAsset(url: example(.m4a)).artwork?.count, 3252)
        XCTAssertEqual(AVAsset(url: example(.mp3)).artwork?.count, 3924)
    }
    
    func testArtist() {
        XCTAssertEqual(AVAsset(url: example(.m4a)).artist, "Artist")
        XCTAssertEqual(AVAsset(url: example(.mp3)).artist, "Artist")
    }
    
    func testTitle() {
        XCTAssertEqual(AVAsset(url: example(.m4a)).title, "Album")
        XCTAssertEqual(AVAsset(url: example(.mp3)).title, "Album")
    }
    
    func testMetadataItem() {
        XCTAssertEqual(AVAsset(url: example(.m4a)).metadataItem("artist")?.stringValue, "Artist")
        XCTAssertEqual(AVAsset(url: example(.mp3)).metadataItem("title")?.stringValue, "Album")
    }
}
