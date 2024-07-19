import Testing
@testable import Mixtapes
import AppKit

struct NSImageTests {
    @Test func pngData() throws {
        let images: [NSImage] = [
            NSImage(contentsOf: resource("example.png"))!,
            NSImage(contentsOf: resource("example.gif"))!,
            NSImage(contentsOf: resource("example.jpg"))!
        ]
        let sizes: [CGSize] = [
            CGSize(width: 420.0, height: 420.0),
            CGSize(width: 720.0, height: 540.0),
            CGSize(width: 180.0, height: 180.0),
            CGSize(width: 132.0, height: 44.0)
        ]
        #expect(images[0].size == sizes[0])
        #expect(images[1].size == sizes[0])
        #expect(images[2].size == sizes[0])
        #expect(NSImage(data: try images[0].pngData(sizes[1]))?.size == sizes[1])
        #expect(NSImage(data: try images[1].pngData(sizes[1]))?.size == sizes[1])
        #expect(NSImage(data: try images[2].pngData(sizes[1]))?.size == sizes[1])
        #expect(NSImage(data: try images[0].pngData(sizes[2]))?.size == sizes[2])
        #expect(NSImage(data: try images[1].pngData(sizes[2]))?.size == sizes[2])
        #expect(NSImage(data: try images[2].pngData(sizes[2]))?.size == sizes[2])
        #expect(NSImage(data: try images[0].pngData(sizes[3]))?.size == sizes[3])
        #expect(NSImage(data: try images[1].pngData(sizes[3]))?.size == sizes[3])
        #expect(NSImage(data: try images[2].pngData(sizes[3]))?.size == sizes[3])
        #expect(throws: Error.self) {
            try images[0].pngData(.zero)
        }
        #expect(throws: Error.self) {
            try images[1].pngData(.zero)
        }
        #expect(throws: Error.self) {
            try images[2].pngData(.zero)
        }
    }
}
