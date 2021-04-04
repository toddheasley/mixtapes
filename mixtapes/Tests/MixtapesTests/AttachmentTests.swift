import XCTest
@testable import Mixtapes

final class AttachmentTests: XCTestCase {
    
}

extension AttachmentTests {
    
    // MARK: Codable
    func testEncode() throws {
        let data: Data = try JSONEncoder(url: URL(string: "https://example.com/mixtapes/")!).encode([
            Attachment(asset: try Asset(url: resource("example.m4a"))),
            Attachment(asset: try Asset(url: resource("example.mp3")))
        ])
        let mocks: [AttachmentTests_Mock] = try JSONDecoder().decode([AttachmentTests_Mock].self, from: AttachmentTests_Data)
        XCTAssertEqual(data, try JSONEncoder().encode(mocks))
    }
    
    func testDecoderInit() throws {
        let attachments: [Attachment] = try JSONDecoder(url: resource("example.m4a")).decode([Attachment].self, from: AttachmentTests_Data)
        if attachments.count == 2 {
            XCTAssertEqual(attachments[0].durationInSeconds, 30)
            XCTAssertEqual(attachments[0].mimeType, "audio/x-m4a")
            XCTAssertEqual(attachments[0].sizeInBytes, 738675)
            XCTAssertEqual(attachments[0].url.lastPathComponent, "example.m4a")
            XCTAssertEqual(attachments[1].durationInSeconds, 30)
            XCTAssertEqual(attachments[1].mimeType, "audio/mpeg")
            XCTAssertEqual(attachments[1].sizeInBytes, 738325)
            XCTAssertEqual(attachments[1].url.lastPathComponent, "example.mp3")
        } else {
            XCTAssertEqual(attachments.count, 2)
        }
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
