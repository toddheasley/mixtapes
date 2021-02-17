import XCTest

extension XCTestCase {
    enum Example: String {
        case m4a, mp3, png, gif, jpg
    }
    
    func example(_ example: Example) -> URL {
        return URL(fileURLWithPath: "example.\(example.rawValue)", relativeTo: Bundle.module.resourceURL!.appendingPathComponent("Resources"))
    }
}
