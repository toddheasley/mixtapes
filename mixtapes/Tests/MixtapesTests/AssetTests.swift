import XCTest
@testable import Mixtapes

final class AssetTests: XCTestCase {
    func testURLInit() throws {
        let aac: Asset = try Asset(url: exampleAAC!)
        XCTAssertEqual(aac.url, exampleAAC!)
        XCTAssertEqual(aac.length, 738675)
        XCTAssertEqual(aac.mimeType, "audio/x-m4a")
        XCTAssertEqual(aac.id, "Example")
        XCTAssertEqual(aac.duration, 30.093)
        XCTAssertEqual(aac.chapters.count, 5)
        XCTAssertEqual(aac.chapters.first?.duration, 0.0...5.712)
        XCTAssertEqual(aac.chapters.first?.title, "Chapter 1")
        XCTAssertEqual(aac.chapters.last?.duration, 26.122...30.093)
        XCTAssertEqual(aac.chapters.last?.title, "Chapter 5")
        XCTAssertEqual(aac.artwork.url.lastPathComponent, "Example.png")
        XCTAssertEqual(aac.artist, "Artist")
        XCTAssertEqual(aac.title, "Album")
        let mp3: Asset = try Asset(url: exampleMP3!)
        XCTAssertEqual(mp3.url, exampleMP3!)
        XCTAssertEqual(mp3.length, 738325)
        XCTAssertEqual(mp3.mimeType, "audio/mpeg")
        XCTAssertEqual(mp3.id, "Example")
        XCTAssertEqual(mp3.duration, 30.066938775510206)
        XCTAssertEqual(mp3.chapters.count, 3)
        XCTAssertEqual(mp3.chapters.first?.duration, nil)
        XCTAssertEqual(mp3.chapters.first?.title, "Chapter 1")
        XCTAssertEqual(mp3.chapters.last?.duration, nil)
        XCTAssertEqual(mp3.chapters.last?.title, "Chapter 3")
        XCTAssertEqual(mp3.artwork.url.lastPathComponent, "Example.jpg")
        XCTAssertEqual(mp3.artist, "Artist")
        XCTAssertEqual(mp3.title, "Album")
    }
    
    func testLength() {
        XCTAssertEqual(try Asset.length(exampleAAC!), 738675)
        XCTAssertEqual(try Asset.length(exampleMP3!), 738325)
    }
    
    func testMimeType() {
        XCTAssertEqual(try Asset.mimeType(exampleAAC!), "audio/x-m4a")
        XCTAssertEqual(try Asset.mimeType(exampleMP3!), "audio/mpeg")
    }
    
    func testID() {
        XCTAssertEqual(try Asset.id(exampleAAC!), "Example")
        XCTAssertEqual(try Asset.id(exampleMP3!), "Example")
    }
}
