import Testing
@testable import Mixtapes
import UniformTypeIdentifiers

struct UTTypeTests {
    @Test func m4A() {
        #expect(UTType.m4a.identifier == "com.apple.m4a-audio")
    }
}
