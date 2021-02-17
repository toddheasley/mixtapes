import XCTest
@testable import Mixtapes

final class AssetTests: XCTestCase {
    func testURLInit() throws {
        let aac: Asset = try Asset(url: example(.m4a))
        XCTAssertEqual(aac.url, example(.m4a))
        XCTAssertEqual(aac.length, 738675)
        XCTAssertEqual(aac.mimeType, "audio/x-m4a")
        XCTAssertEqual(aac.id, "example")
        XCTAssertEqual(aac.duration, 30.093)
        XCTAssertEqual(aac.chapters.count, 5)
        XCTAssertEqual(aac.chapters.first?.duration, 0.0...5.712)
        XCTAssertEqual(aac.chapters.first?.title, "Chapter 1")
        XCTAssertEqual(aac.chapters.last?.duration, 26.122...30.093)
        XCTAssertEqual(aac.chapters.last?.title, "Chapter 5")
        XCTAssertEqual(aac.artwork.url.lastPathComponent, "example.png")
        XCTAssertEqual(aac.artist, "Artist")
        XCTAssertEqual(aac.title, "Album")
        let mp3: Asset = try Asset(url: example(.mp3))
        XCTAssertEqual(mp3.url, example(.mp3))
        XCTAssertEqual(mp3.length, 738325)
        XCTAssertEqual(mp3.mimeType, "audio/mpeg")
        XCTAssertEqual(mp3.id, "example")
        XCTAssertEqual(mp3.duration, 30.066938775510206)
        XCTAssertEqual(mp3.chapters.count, 3)
        XCTAssertNil(mp3.chapters.first?.duration)
        XCTAssertEqual(mp3.chapters.first?.title, "Chapter 1")
        XCTAssertNil(mp3.chapters.last?.duration)
        XCTAssertEqual(mp3.chapters.last?.title, "Chapter 3")
        XCTAssertEqual(mp3.artwork.url.lastPathComponent, "example.jpg")
        XCTAssertEqual(mp3.artist, "Artist")
        XCTAssertEqual(mp3.title, "Album")
    }
}
