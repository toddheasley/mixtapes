import XCTest
import AVFoundation
@testable import Mixtapes

final class AVAssetTests: XCTestCase {
    
}

extension AVAssetTests {
    func testChapterMetadataGroups() async throws {
        let m4a: [AVMetadataGroup] = try await AVAsset(url: resource("example.m4a")).chapterMetadataGroups()
        XCTAssertEqual(m4a.count, 5)
        let mp3: [AVMetadataGroup] = try await AVAsset(url: resource("example.mp3")).chapterMetadataGroups()
        XCTAssertEqual(mp3.count, 3)
    }
    
    func testArtwork() async throws {
        let m4a: Data = try await AVAsset(url: resource("example.m4a")).artwork()
        XCTAssertEqual(m4a.count, 3252)
        let mp3: Data = try await AVAsset(url: resource("example.mp3")).artwork()
        XCTAssertEqual(mp3.count, 3924)
    }
    
    func testArtist() async throws {
        let m4a: String = try await AVAsset(url: resource("example.m4a")).artist()
        XCTAssertEqual(m4a, "Artist")
        let mp3: String = try await AVAsset(url: resource("example.mp3")).artist()
        XCTAssertEqual(mp3, "Artist")
    }
    
    func testTitle() async throws {
        let m4a: String = try await AVAsset(url: resource("example.m4a")).title()
        XCTAssertEqual(m4a, "Album")
        let mp3: String = try await AVAsset(url: resource("example.mp3")).title()
        XCTAssertEqual(mp3, "Album")
    }
    
    func testMetadataItem() async throws {
        let m4a: String? = try await AVAsset(url: resource("example.m4a")).metadataItem("artist").load(.stringValue)
        XCTAssertEqual(m4a, "Artist")
        let mp3: String? = try await AVAsset(url: resource("example.mp3")).metadataItem("title").load(.stringValue)
        XCTAssertEqual(mp3, "Album")
    }
}
