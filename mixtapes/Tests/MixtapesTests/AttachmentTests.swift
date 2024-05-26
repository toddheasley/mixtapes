import XCTest
@testable import Mixtapes

final class AttachmentTests: XCTestCase {
    func testURLInit() async throws {
        let attachment: Attachment = try await Attachment(url: resource("example.m4a"))
        XCTAssertEqual(attachment.durationInSeconds, 30)
        XCTAssertEqual(attachment.mimeType, "audio/x-m4a")
    }
}

extension AttachmentTests {
    
    // MARK: Enodable
    func testEncode() async throws {
        let m4a: Attachment = try await Attachment(url: resource("example.m4a"))
        let mp3: Attachment = try await Attachment(url: resource("example.mp3"))
        let data: Data = try JSONEncoder(url:  URL(string: "https://example.com/mixtapes/")!).encode([
            m4a,
            mp3
        ])
        let mocks: [AttachmentTests_Mock] = try JSONDecoder().decode([AttachmentTests_Mock].self, from: AttachmentTests_Data)
        XCTAssertEqual(data.count, try JSONEncoder().encode(mocks).count)
    }
}

private struct AttachmentTests_Mock: Codable {
    let duration_in_seconds: Int
    let mime_type: String
    let size_in_bytes: Int
    let url: String
}

private let AttachmentTests_Data: Data = """
[
    {
        "duration_in_seconds": 30,
        "mime_type": "audio/x-m4a",
        "size_in_bytes": 738675,
        "url": "https://example.com/mixtapes/example.m4a"
    },
    {
        "duration_in_seconds": 30,
        "mime_type": "audio/mpeg",
        "size_in_bytes": 738325,
        "url": "https://example.com/mixtapes/example.mp3"
    }
]
""".data(using: .utf8)!
