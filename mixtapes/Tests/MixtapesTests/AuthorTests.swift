import Testing
@testable import Mixtapes

struct AuthorTests {
    
    // MARK: CustomStringConvertible
    @Test func description() {
        #expect(Author("Todd Heasley", url: "mailto:toddheasley@me.com").description == "Todd Heasley")
        #expect(Author(url: "mailto:toddheasley@me.com").description == "mailto:toddheasley@me.com")
    }
}
