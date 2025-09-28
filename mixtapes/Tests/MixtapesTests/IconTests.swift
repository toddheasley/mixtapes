import Testing
@testable import Mixtapes
import Foundation

struct IconTests {
    func testIsDefault() throws {
        let url: URL = resource("example.m4a")
        #expect(try !Icon(url: url, path: "example.png").isDefault)
        #expect(try !Icon(url: url, path: "example.jpg").isDefault)
        #expect(try Icon(url: url).isDefault)
    }
    
    @Test func data() {
        #expect(Icon.data.count == 31154)
    }
    
    @Test func reset() throws {
        var icon: Icon = try Icon(url: resource("example.m4a"))
        #expect(icon.url.relativePath == "icon.png")
        #expect(icon.data.count == 31154)
        _ = try icon.reset(try! Data(contentsOf: resource("example.png")))
        #expect(icon.url.relativePath == "icon.png")
        #expect(icon.data.count == 1333)
        #expect(throws: Error.self) {
            try icon.reset(try! Data(contentsOf: resource("example.gif")))
        }
        #expect(icon.url.relativePath == "icon.png")
        #expect(icon.data.count == 1333)
        _ = try icon.reset(try! Data(contentsOf: resource("example.jpg")))
        #expect(icon.url.relativePath == "icon.jpg")
        #expect(icon.data.count == 3897)
        _ = try icon.reset()
        #expect(icon.url.relativePath == "icon.png")
        #expect(icon.data.count == 31154)
    }
    
    @Test func urlInit() throws {
        let url: URL = resource("example.m4a")
        #expect(try Icon(url: url, path: "example.jpg").url.relativePath == "icon.jpg")
        #expect(try Icon(url: url, path: "example.jpg").data.count == 3897)
        #expect(try Icon(url: url, path: "example.gif").url.relativePath == "icon.png")
        #expect(try Icon(url: url, path: "example.gif").data.count == 31154)
        #expect(try Icon(url: url, path: "example.foo").url.relativePath == "icon.png")
        #expect(try Icon(url: url, path: "example.foo").data.count == 31154)
        #expect(try Icon(url: url).url.relativePath == "icon.png")
        #expect(try Icon(url: url).data.count == 31154)
    }
}
