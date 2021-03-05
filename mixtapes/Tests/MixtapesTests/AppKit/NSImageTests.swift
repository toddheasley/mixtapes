import XCTest
@testable import Mixtapes

final class NSImageTests: XCTestCase {
    
}

extension NSImageTests {
    func testPNGData() throws {
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
        XCTAssertEqual(images[0].size, sizes[0])
        XCTAssertEqual(images[1].size, sizes[0])
        XCTAssertEqual(images[2].size, sizes[0])
        XCTAssertEqual(NSImage(data: try images[0].pngData(sizes[1]))?.size, sizes[1])
        XCTAssertEqual(NSImage(data: try images[1].pngData(sizes[1]))?.size, sizes[1])
        XCTAssertEqual(NSImage(data: try images[2].pngData(sizes[1]))?.size, sizes[1])
        XCTAssertEqual(NSImage(data: try images[0].pngData(sizes[2]))?.size, sizes[2])
        XCTAssertEqual(NSImage(data: try images[1].pngData(sizes[2]))?.size, sizes[2])
        XCTAssertEqual(NSImage(data: try images[2].pngData(sizes[2]))?.size, sizes[2])
        XCTAssertEqual(NSImage(data: try images[0].pngData(sizes[3]))?.size, sizes[3])
        XCTAssertEqual(NSImage(data: try images[1].pngData(sizes[3]))?.size, sizes[3])
        XCTAssertEqual(NSImage(data: try images[2].pngData(sizes[3]))?.size, sizes[3])
        XCTAssertThrowsError(try images[0].pngData(.zero))
        XCTAssertThrowsError(try images[1].pngData(.zero))
        XCTAssertThrowsError(try images[2].pngData(.zero))
    }
}
