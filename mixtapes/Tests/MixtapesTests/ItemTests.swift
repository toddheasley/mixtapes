import XCTest
@testable import Mixtapes

final class ItemTests: XCTestCase {
    
}

extension ItemTests {
    
    // MARK: Codable
    func testEncode() throws {
        let decoder: JSONDecoder = JSONDecoder(url: resource("index.json"))
        let encoder: JSONEncoder = JSONEncoder(url: URL(string: "https://example.com/mixtapes/")!, formatting: [.sortedKeys])
        let item: Item = try decoder.decode(Item.self, from: ItemTests_Data)
        let data: Data = try encoder.encode(item)
        let mock: ItemTests_Mock = try decoder.decode(ItemTests_Mock.self, from: ItemTests_Data)
        XCTAssertEqual(data, try encoder.encode(mock))
    }
    
    func testDecoderInit() throws {
        let item: Item = try JSONDecoder(url: resource("example.m4a")).decode(Item.self, from: ItemTests_Data)
        XCTAssertEqual(item.attachment.durationInSeconds, 30)
        XCTAssertEqual(item.attachment.mimeType, "audio/x-m4a")
        XCTAssertEqual(item.attachment.sizeInBytes, 738675)
        XCTAssertEqual(item.attachment.url.lastPathComponent, "example.m4a")
        XCTAssertEqual(item.date.published, Date(timeIntervalSince1970: 0.0))
        XCTAssertNil(item.date.modified)
        XCTAssertEqual(item.id, "example")
        XCTAssertEqual(item.image.lastPathComponent, "example.png")
        XCTAssertEqual(item.summary, "Artist")
        XCTAssertEqual(item.title, "Album")
        XCTAssertTrue(item.isExplicit)
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
