import Testing
@testable import Mixtapes

struct StringTests {
    @Test func leftPadded() {
        #expect("|".leftPadded(to: 0, with: "+") == "")
        #expect("|".leftPadded(to: -1, with: "+") == "")
        #expect("|".leftPadded(to: 1, with: "+") == "|")
        #expect("|".leftPadded(to: 8, with: "+") == "+++++++|")
        #expect("|".leftPadded(to: 8) == "       |")
    }
}
