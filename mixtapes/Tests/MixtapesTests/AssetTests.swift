import Testing
@testable import Mixtapes

struct AssetTests {
    @Test func urlInit() async throws {
        let aac: Asset = try await Asset(url: resource("example.m4a"))
        #expect(aac.url == resource("example.m4a"))
        #expect(aac.length == 738675)
        #expect(aac.mimeType == "audio/x-m4a")
        #expect(aac.id == "example")
        #expect(aac.duration == 30.093)
        #expect(aac.chapters.count == 5)
        #expect(aac.chapters.first?.id == "1")
        #expect(aac.chapters.first?.duration == 0.0...5.712)
        #expect(aac.chapters.first?.title == "Chapter 1")
        #expect(aac.chapters.last?.id == "5")
        #expect(aac.chapters.last?.duration == 26.122...30.093)
        #expect(aac.chapters.last?.title == "Chapter 5")
        #expect(aac.artwork.url.lastPathComponent == "example.png")
        #expect(aac.artist == "Artist")
        #expect(aac.title == "Album")
        let mp3: Asset = try await Asset(url: resource("example.mp3"))
        #expect(mp3.url == resource("example.mp3"))
        #expect(mp3.length == 738325)
        #expect(mp3.mimeType == "audio/mpeg")
        #expect(mp3.id == "example")
        #expect(mp3.duration == 30.066938775510206)
        #expect(mp3.chapters.count == 3)
        #expect(mp3.chapters.first?.id == "1")
        #expect(mp3.chapters.first?.duration == nil)
        #expect(mp3.chapters.first?.title == "Chapter 1")
        #expect(mp3.chapters.last?.id == "3")
        #expect(mp3.chapters.last?.duration == nil)
        #expect(mp3.chapters.last?.title == "Chapter 3")
        #expect(mp3.artwork.url.lastPathComponent == "example.jpg")
        #expect(mp3.artist == "Artist")
        #expect(mp3.title == "Album")
    }
}
