import Testing
@testable import Mixtapes
import Foundation

struct ErrorTests {
    @Test func descriptionInit() {
        #expect(Error("Error description", url: URL(string: "https://example.com/path")).description == "Error description: https://example.com/path")
        #expect(Error("Error description", url: URL(fileURLWithPath: "/example/path")).description == "Error description: file:///example/path")
        #expect(Error("Error description", url: nil).description == "Error description")
        #expect(Error("Error description").description == "Error description")
    }
}
