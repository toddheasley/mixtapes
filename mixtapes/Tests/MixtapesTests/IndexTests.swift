import XCTest
@testable import Mixtapes

final class IndexTests: XCTestCase {
    func testHomepage() throws {
        var index: Index = try Index(url: resources)
        XCTAssertNil(index.homepageURL)
        XCTAssertEqual(index.homepage, "")
        index.homepage = "https://example.com/mixtapes/"
        XCTAssertEqual(index.homepageURL, URL(homepage: "https://example.com/mixtapes/", path: "index.html"))
        XCTAssertEqual(index.homepage, "https://example.com/mixtapes/")
        index.homepage = ""
        XCTAssertNil(index.homepageURL)
        XCTAssertEqual(index.homepage, "")
    }
    
    func testURLInit() throws {
        XCTAssertThrowsError(try Index(url: resources.appendingPathComponent("example")))
        XCTAssertNoThrow(try Index(url: resources))
    }
    
    func testFeedURL() throws {
        var index: Index = try Index(url: resources)
        XCTAssertNil(index.feedURL)
        index.homepage = "https://example.com/mixtapes/"
        XCTAssertEqual(index.feedURL, URL(homepage: "https://example.com/mixtapes/", path: "index.json"))
    }
    
    func testIconURL() throws {
        var index: Index = try Index(url: resources)
        XCTAssertNil(index.iconURL)
        index.homepage = "https://example.com/mixtapes/"
        XCTAssertEqual(index.iconURL, URL(homepage: "https://example.com/mixtapes/", path: "icon.png"))
    }
}

extension IndexTests {
    
    // MARK: Codable
    func testEncode() throws {
        let decoder: JSONDecoder = JSONDecoder(url: resource("index.json"))
        let encoder: JSONEncoder = JSONEncoder(url: URL(string: "https://example.com/mixtapes/")!, formatting: [.sortedKeys])
        let index: Index = try decoder.decode(Index.self, from: IndexTests_Data)
        let data: Data = try encoder.encode(index)
        let mock: IndexTests_Mock = try decoder.decode(IndexTests_Mock.self, from: IndexTests_Data)
        XCTAssertEqual(data, try encoder.encode(mock))
    }
    
    func testDecoderInit() throws {
        let index: Index = try JSONDecoder(url: URL(string: "index.json", relativeTo: resources)!).decode(Index.self, from: IndexTests_Data)
        XCTAssertEqual(index.authors.first?.name, "Todd Heasley")
        XCTAssertEqual(index.authors.first?.url, URL(string: "mailto:toddheasley@me.com"))
        XCTAssertEqual(index.authors.count, 1)
        XCTAssertEqual(index.description, "Example mixtapes podcast")
        XCTAssertEqual(index.feedURL, URL(homepage: "https://example.com/mixtapes/", path: "index.json"))
        XCTAssertEqual(index.homepage, "https://example.com/mixtapes/")
        XCTAssertEqual(index.homepageURL, URL(homepage: "https://example.com/mixtapes/", path: "index.html"))
        XCTAssertEqual(index.iconURL, URL(homepage: "https://example.com/mixtapes/", path: "icon.png"))
        XCTAssertEqual(index.items.count, 2)
        XCTAssertEqual(index.items.first?.attachment.url.lastPathComponent, "example.m4a")
        XCTAssertEqual(index.items.last?.attachment.url.lastPathComponent, "example.mp3")
        XCTAssertEqual(index.title, "Mixtapes")
    }
}

private struct IndexTests_Mock: Codable {
    struct Author: Codable {
        let url: URL
        let name: String?
    }
    
    struct Item: Codable {
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
        let tags: [String]?
        let title: String
    }
    
    let authors: [Author]?
    let description: String
    let feed_url: String
    let home_page_url: String
    let icon: String
    let items: [Item]
    let title: String
    let version: String
}

private let IndexTests_Data: Data = """
{
    "authors": [
        {
            "name": "Todd Heasley",
            "url": "mailto:toddheasley@me.com"
        }
    ],
    "description": "Example mixtapes podcast",
    "feed_url": "https://example.com/mixtapes/index.json",
    "home_page_url": "https://example.com/mixtapes/index.html",
    "icon": "https://example.com/mixtapes/icon.png",
    "items": [
        {
            "attachments": [
                {
                    "duration_in_seconds": 30,
                    "mime_type": "audio/x-m4a",
                    "size_in_bytes": 738675,
                    "url": "https://example.com/mixtapes/example.m4a"
                }
            ],
            "date_published": "1970-01-01T00:00:01Z",
            "id": "example",
            "image": "https://example.com/mixtapes/example.png",
            "summary": "Artist",
            "tags": [
                "explicit"
            ],
            "title": "Album"
        },
        {
            "attachments": [
                {
                    "duration_in_seconds": 30,
                    "mime_type": "audio/mpeg",
                    "size_in_bytes": 738325,
                    "url": "https://example.com/mixtapes/example.mp3"
                }
            ],
            "date_published": "1970-01-01T00:00:00Z",
            "id": "example",
            "image": "https://example.com/mixtapes/example.jpg",
            "summary": "Artist",
            "title": "Album"
        }
    ],
    "title": "Mixtapes",
    "version": "https://jsonfeed.org/version/1.1"
}
""".data(using: .utf8)!
