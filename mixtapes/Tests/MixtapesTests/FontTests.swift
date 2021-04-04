import XCTest
@testable import Mixtapes

final class FontTests: XCTestCase {
    func testNameFormat() throws {
        XCTAssertEqual(Font.Name.gaegu.format, "woff")
        XCTAssertEqual(Font.Name.gaegu.path, "gaegu.woff")
        XCTAssertEqual(Font.Name.gaegu.description, "gaegu")
    }
    
    func testNameInit() throws {
        let font: Font = try Font(.gaegu, url: resources)
        XCTAssertEqual(font.url, URL(fileURLWithPath: "gaegu.woff", relativeTo: resources))
        XCTAssertEqual(font.data.count, 24816)
        
    }
}
