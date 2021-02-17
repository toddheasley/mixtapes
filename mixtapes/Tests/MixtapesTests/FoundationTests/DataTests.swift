import XCTest
@testable import Mixtapes

final class DataTests: XCTestCase {
    
}

extension DataTests {
    func testPathExtension() throws {
        XCTAssertEqual(try Data(contentsOf: example(.png)).pathExtension, "png")
        XCTAssertNil(try Data(contentsOf: example(.gif)).pathExtension)
        XCTAssertEqual(try Data(contentsOf: example(.jpg)).pathExtension, "jpg")
    }
}
