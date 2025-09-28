import Testing
@testable import Mixtapes
import Foundation

struct AttachmentTests {
    @Test func urlInit() async throws {
        let attachment = try await Attachment(url: resource("example.m4a"))
        #expect(attachment.durationInSeconds == 30)
        #expect(attachment.mimeType == "audio/x-m4a")
    }
}

extension AttachmentTests {
    
    // MARK: Enodable
    func testEncode() async throws {
        let m4a = try await Attachment(url: resource("example.m4a"))
        let mp3 = try await Attachment(url: resource("example.mp3"))
        let data: Data = try JSONEncoder(url:  URL(string: "https://example.com/mixtapes/")!).encode([
            m4a,
            mp3
        ])
        let mocks: [AttachmentTests_Mock] = try JSONDecoder().decode([AttachmentTests_Mock].self, from: AttachmentTests_Data)
        #expect(try JSONEncoder().encode(mocks).count == data.count)
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
