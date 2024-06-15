import Testing
@testable import Mixtapes
import Foundation

struct DataTests {
    @Test func pathExtension() throws {
        #expect(try Data(contentsOf: resource("example.png")).pathExtension == "png")
        #expect(try Data(contentsOf: resource("example.gif")).pathExtension == nil)
        #expect(try Data(contentsOf: resource("example.jpg")).pathExtension == "jpg")
    }
}
