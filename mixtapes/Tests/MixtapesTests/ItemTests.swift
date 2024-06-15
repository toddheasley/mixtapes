import Testing
@testable import Mixtapes
import Foundation

struct ItemTests {
    
    // MARK: Encodable
    @Test func encode() async throws {
        let decoder: JSONDecoder = JSONDecoder(url: resources)
        let encoder: JSONEncoder = JSONEncoder(url: URL(string: "https://example.com/mixtapes/")!, formatting: [.sortedKeys])
        let metadata: Item.Metadata = try decoder.decode(Item.Metadata.self, from: ItemTests_Data)
        let item: Item = try await Item(metadata: metadata)
        #expect(try encoder.encode(item).count == 312)
    }
    
    // MARK: Decodable
    @Test func metadataDecoderInit() throws {
        let metadata: Item.Metadata = try JSONDecoder(url: resources).decode(Item.Metadata.self, from: ItemTests_Data)
        #expect(metadata.published == Date(timeIntervalSince1970: 0.0))
        #expect(metadata.isExplicit)
        #expect(metadata.url.lastPathComponent == "example.m4a")
    }
}

private struct ItemTests_Mock: Codable {
    struct Attachment: Codable {
        let duration_in_seconds: Int
        let mime_type: String
        let size_in_bytes: Int
        let url: String
    }
    
    let attachments: [Attachment]
    let date_published: Date
    let id: String
    let image: String
    let summary: String
    let tags: [String]
    let title: String
}

private let ItemTests_Data: Data = """
{
    "attachments": [
        {
            "duration_in_seconds": 30,
            "mime_type": "audio/x-m4a",
            "size_in_bytes": 738675,
            "url": "https://example.com/mixtapes/example.m4a"
        }
    ],
    "date_published": "1970-01-01T00:00:00Z",
    "id": "example",
    "image": "https://example.com/mixtapes/example.png",
    "summary": "Artist",
    "tags": [
        "explicit"
    ],
    "title": "Album"
}
""".data(using: .utf8)!
