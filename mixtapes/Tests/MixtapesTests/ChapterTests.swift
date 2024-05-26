import XCTest
@testable import Mixtapes

final class ChapterTests: XCTestCase {
    func testMetadataInit() async throws {
        let aac: Asset = try await Asset(url: resource("example.m4a"))
        if aac.chapters.count == 5 {
            XCTAssertEqual(aac.chapters[0].id, "1")
            XCTAssertEqual(aac.chapters[0].duration, 0.0...5.712)
            XCTAssertEqual(aac.chapters[0].title, "Chapter 1")
            XCTAssertEqual(aac.chapters[1].id, "2")
            XCTAssertEqual(aac.chapters[1].duration, 5.712...15.278)
            XCTAssertEqual(aac.chapters[1].title, "Chapter 2")
            XCTAssertEqual(aac.chapters[2].id, "3")
            XCTAssertEqual(aac.chapters[2].duration, 15.278...18.923000000000002)
            XCTAssertEqual(aac.chapters[2].title, "Chapter 3")
            XCTAssertEqual(aac.chapters[3].id, "4")
            XCTAssertEqual(aac.chapters[3].duration, 18.923...26.122)
            XCTAssertEqual(aac.chapters[3].title, "Chapter 4")
            XCTAssertEqual(aac.chapters[4].id, "5")
            XCTAssertEqual(aac.chapters[4].duration, 26.122...30.093)
            XCTAssertEqual(aac.chapters[4].title, "Chapter 5")
        } else {
            XCTAssertEqual(aac.chapters.count, 5)
        }
        let mp3: Asset = try await Asset(url: resource("example.mp3"))
        if mp3.chapters.count == 3 {
            XCTAssertEqual(mp3.chapters[0].id, "1")
            XCTAssertNil(mp3.chapters[0].duration)
            XCTAssertEqual(mp3.chapters[0].title, "Chapter 1")
            XCTAssertEqual(mp3.chapters[1].id, "2")
            XCTAssertNil(mp3.chapters[1].duration)
            XCTAssertEqual(mp3.chapters[1].title, "Chapter 2")
            XCTAssertEqual(mp3.chapters[2].id, "3")
            XCTAssertNil(mp3.chapters[2].duration)
            XCTAssertEqual(mp3.chapters[2].title, "Chapter 3")
        } else {
            XCTAssertEqual(mp3.chapters.count, 3)
        }
    }
}
