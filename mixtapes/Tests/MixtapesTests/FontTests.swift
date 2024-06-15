import Testing
@testable import Mixtapes
import Foundation

struct FontTests {
    @Test func nameFormat() throws {
        #expect(Font.Name.gaegu.format == "woff")
        #expect(Font.Name.gaegu.path == "gaegu.woff")
        #expect(Font.Name.gaegu.description == "gaegu")
    }
    
    @Test func nameInit() throws {
        let font: Font = try Font(.gaegu, url: resources)
        #expect(font.url == URL(fileURLWithPath: "gaegu.woff", relativeTo: resources))
        #expect(font.data.count == 24816)
    }
}
