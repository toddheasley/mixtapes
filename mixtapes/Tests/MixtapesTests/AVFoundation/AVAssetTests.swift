import Testing
@testable import Mixtapes
import AVFoundation

struct AVAssetTests {
    @Test func chapterMetadataGroups() async throws {
        let m4a: [AVMetadataGroup] = try await AVURLAsset(url: resource("example.m4a")).chapterMetadataGroups()
        #expect(m4a.count == 5)
        let mp3: [AVMetadataGroup] = try await AVURLAsset(url: resource("example.mp3")).chapterMetadataGroups()
        #expect(mp3.count == 3)
    }
    
    @Test func artwork() async throws {
        let m4a: Data = try await AVURLAsset(url: resource("example.m4a")).artwork()
        #expect(m4a.count == 3252)
        let mp3: Data = try await AVURLAsset(url: resource("example.mp3")).artwork()
        #expect(mp3.count == 3924)
    }
    
    @Test func artist() async throws {
        let m4a: String = try await AVURLAsset(url: resource("example.m4a")).artist()
        #expect(m4a == "Artist")
        let mp3: String = try await AVURLAsset(url: resource("example.mp3")).artist()
        #expect(mp3 == "Artist")
    }
    
    @Test func title() async throws {
        let m4a: String = try await AVURLAsset(url: resource("example.m4a")).title()
        #expect(m4a == "Album")
        let mp3: String = try await AVURLAsset(url: resource("example.mp3")).title()
        #expect(mp3 == "Album")
    }
    
    @Test func metadataItem() async throws {
        let m4a: String? = try await AVURLAsset(url: resource("example.m4a")).metadataItem("artist").load(.stringValue)
        #expect(m4a == "Artist")
        let mp3: String? = try await AVURLAsset(url: resource("example.mp3")).metadataItem("title").load(.stringValue)
        #expect(mp3 == "Album")
    }
}
