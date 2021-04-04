import XCTest
import UniformTypeIdentifiers
@testable import Mixtapes

final class UTTypeTests: XCTestCase {
    
}

extension UTTypeTests {
    func testM4A() {
        XCTAssertEqual(UTType.m4a.identifier, "com.apple.m4a-audio")
    }
}
