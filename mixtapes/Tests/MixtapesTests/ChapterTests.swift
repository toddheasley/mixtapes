import Testing
@testable import Mixtapes

struct ChapterTests {
    @Test func metadataInit() async throws {
        let aac: Asset = try await Asset(url: resource("example.m4a"))
        if aac.chapters.count == 5 {
            #expect(aac.chapters[0].id == "1")
            #expect(aac.chapters[0].duration == 0.0...5.712)
            #expect(aac.chapters[0].title == "Chapter 1")
            #expect(aac.chapters[1].id == "2")
            #expect(aac.chapters[1].duration == 5.712...15.278)
            #expect(aac.chapters[1].title == "Chapter 2")
            #expect(aac.chapters[2].id == "3")
            #expect(aac.chapters[2].duration == 15.278...18.923000000000002)
            #expect(aac.chapters[2].title == "Chapter 3")
            #expect(aac.chapters[3].id == "4")
            #expect(aac.chapters[3].duration == 18.923...26.122)
            #expect(aac.chapters[3].title == "Chapter 4")
            #expect(aac.chapters[4].id == "5")
            #expect(aac.chapters[4].duration == 26.122...30.093)
            #expect(aac.chapters[4].title == "Chapter 5")
        } else {
            #expect(aac.chapters.count == 5)
        }
        let mp3: Asset = try await Asset(url: resource("example.mp3"))
        if mp3.chapters.count == 3 {
            #expect(mp3.chapters[0].id == "1")
            #expect(mp3.chapters[0].duration == nil)
            #expect(mp3.chapters[0].title == "Chapter 1")
            #expect(mp3.chapters[1].id == "2")
            #expect(mp3.chapters[1].duration == nil)
            #expect(mp3.chapters[1].title == "Chapter 2")
            #expect(mp3.chapters[2].id == "3")
            #expect(mp3.chapters[2].duration == nil)
            #expect(mp3.chapters[2].title == "Chapter 3")
        } else {
            #expect(mp3.chapters.count == 3)
        }
    }
}
