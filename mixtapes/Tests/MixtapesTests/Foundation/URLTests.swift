import Testing
@testable import Mixtapes
import AVFoundation
import Foundation

struct URLTests {
    @Test func fileSize() {
        #expect(resources.fileSize == nil)
        #expect(URL(string: "https://example.com")!.fileSize == nil)
        #expect(resource("example.m4a").fileSize == 738675)
        #expect(resource("example.mp3").fileSize == 738325)
        #expect(resource("example.png").fileSize == 1333)
        #expect(resource("example.gif").fileSize == 1290)
        #expect(resource("example.jpg").fileSize == 3897)
    }
    
    @Test func contentType() {
        #expect(URL(string: "https://example.com")!.contentType == nil)
        #expect(resource("example.m4a").contentType == UTType("com.apple.m4a-audio"))
        #expect(resource("example.mp3").contentType == .mp3)
        #expect(resource("example.png").contentType == .png)
        #expect(resource("example.gif").contentType == .gif)
        #expect(resource("example.jpg").contentType == .jpeg)
    }
    
    @Test func id() {
        #expect(URL(string: "https://example.com")!.id == nil)
        #expect(URL(string: "https://example.com/mixtapes/.mp3")!.id == nil)
        #expect(resource("example.mp3").id == "example")
    }
    
    @Test func homepageInit() {
        #expect(URL(homepage: "https://example.com/mixtapes/index.json") == URL(string: "https://example.com/mixtapes/"))
        #expect(URL(homepage: "http://example.com/mixtapes", path: "index.json") == URL(string: "index.json", relativeTo: URL(string: "http://example.com/mixtapes/")))
    }
}
