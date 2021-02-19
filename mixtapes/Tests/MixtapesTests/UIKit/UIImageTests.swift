import XCTest
@testable import Mixtapes

final class UIImageTests: XCTestCase {
    func testResized() throws {
        let images: [UIImage] = [
            UIImage(data: try! Data(contentsOf: resource("example.png")))!,
            UIImage(data: try! Data(contentsOf: resource("example.gif")))!,
            UIImage(data: try! Data(contentsOf: resource("example.jpg")))!
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
        XCTAssertEqual(images[0].resized(sizes[1])?.size, sizes[1])
        XCTAssertEqual(images[1].resized(sizes[1])?.size, sizes[1])
        XCTAssertEqual(images[2].resized(sizes[1])?.size, sizes[1])
        XCTAssertEqual(images[0].resized(sizes[2])?.size, sizes[2])
        XCTAssertEqual(images[1].resized(sizes[2])?.size, sizes[2])
        XCTAssertEqual(images[2].resized(sizes[2])?.size, sizes[2])
        XCTAssertEqual(images[0].resized(sizes[3])?.size, sizes[3])
        XCTAssertEqual(images[1].resized(sizes[3])?.size, sizes[3])
        XCTAssertEqual(images[2].resized(sizes[3])?.size, sizes[3])
        XCTAssertNil(images[0].resized(.zero))
        XCTAssertNil(images[1].resized(.zero))
        XCTAssertNil(images[2].resized(.zero))
    }
}
