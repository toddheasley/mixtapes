import XCTest
@testable import Mixtapes

final class DataTests: XCTestCase {
    
}

extension DataTests {
    func testPathExtension() throws {
        XCTAssertEqual(try Data(contentsOf: resource("example.png")).pathExtension, "png")
        XCTAssertNil(try Data(contentsOf: resource("example.gif")).pathExtension)
        XCTAssertEqual(try Data(contentsOf: resource("example.jpg")).pathExtension, "jpg")
    }
}
