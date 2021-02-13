import XCTest

extension XCTestCase {
    var exampleAAC: URL? {
        return Bundle.module.url(forResource: "Example", withExtension: "m4a")
    }
    
    var exampleMP3: URL? {
        return Bundle.module.url(forResource: "Example", withExtension: "mp3")
    }
}
