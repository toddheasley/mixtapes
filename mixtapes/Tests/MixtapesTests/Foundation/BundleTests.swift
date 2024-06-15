import Testing
@testable import Mixtapes
import Foundation

struct BundleTests {
    @Test func resource() throws {
        #expect(try Bundle.module.resource("example.png").count == 1333)
        #expect(throws: NSError.self) {
            try Bundle.module.resource("example.foo")
        }
    }
}
