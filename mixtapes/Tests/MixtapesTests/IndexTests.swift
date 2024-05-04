import XCTest
@testable import Mixtapes

final class IndexTests: XCTestCase {
    func testHomepage() async throws {
        var index: Index = try await Index(url: resources)
        index.homepage = ""
        XCTAssertNil(index.homepageURL)
        XCTAssertEqual(index.homepage, "")
        index.homepage = "https://example.com/mixtapes/"
        XCTAssertEqual(index.homepageURL, URL(homepage: "https://example.com/mixtapes/", path: "index.html"))
        XCTAssertEqual(index.homepage, "https://example.com/mixtapes/")
        index.homepage = ""
        XCTAssertNil(index.homepageURL)
        XCTAssertEqual(index.homepage, "")
        
        print(resources.absoluteString)
    }
    
    func testURLInit() async throws {
        do {
            let _ = try await Index(url: resources.appendingPathComponent("example"))
            XCTFail()
        } catch {
            XCTAssertTrue((error as? Error)?.description.hasPrefix("Resource not found:") ?? false)
        }
        var index: Index = try await Index(url: resources)
        index.authors = [
            Author("Name", url: "mailto:name@example.com")
        ]
        index.homepage = "https://example.com"
        index.title = "Example"
        try index.write()
        index = try await Index(url: resources)
        XCTAssertEqual(index.authors.first?.name, "Name")
        XCTAssertEqual(index.authors.first?.url, "mailto:name@example.com")
        XCTAssertEqual(index.homepage, "https://example.com/")
        XCTAssertEqual(index.title, "Example")
    }
    
    func testFeedURL() async throws {
        var index: Index = try await Index(url: resources)
        index.homepage = ""
        XCTAssertNil(index.feedURL)
        index.homepage = "https://example.com/mixtapes/"
        XCTAssertEqual(index.feedURL, URL(homepage: "https://example.com/mixtapes/", path: "index.json"))
    }
    
    func testIconURL() async throws {
        var index: Index = try await Index(url: resources)
        index.homepage = ""
        XCTAssertNil(index.iconURL)
        index.homepage = "https://example.com/mixtapes/"
        XCTAssertEqual(index.iconURL, URL(homepage: "https://example.com/mixtapes/", path: "icon.png"))
    }
}

extension IndexTests {
    
    // MARK: Codable
    func testEncode() async throws {
        let decoder: JSONDecoder = JSONDecoder(url: URL(string: "index.json", relativeTo: resources)!)
        let encoder: JSONEncoder = JSONEncoder(url: URL(string: "https://example.com/mixtapes/")!, formatting: [.sortedKeys])
        let metadata: Index.Metadata = try decoder.decode(Index.Metadata.self, from: IndexTests_Data)
        let index: Index = try await Index(metadata: metadata)
        let data: Data = try encoder.encode(index)
        if let string = String(data: data, encoding: .utf8) {
            print(string)
        }
        let mock: IndexTests_Mock = try decoder.decode(IndexTests_Mock.self, from: IndexTests_Data)
        if let string = String(data: try encoder.encode(mock), encoding: .utf8) {
            print(string)
        }
        XCTAssertEqual(data, try encoder.encode(mock))
    }
    
    func testMetadataDecoderInit() throws {
        let metadata: Index.Metadata = try JSONDecoder(url: URL(string: "index.json", relativeTo: resources)!).decode(Index.Metadata.self, from: IndexTests_Data)
        XCTAssertEqual(metadata.authors.first?.name, "Todd Heasley")
        XCTAssertEqual(metadata.authors.first?.url, "mailto:toddheasley@me.com")
        XCTAssertEqual(metadata.authors.count, 1)
        XCTAssertEqual(metadata.description, "Example mixtapes podcast")
        XCTAssertEqual(metadata.homepage, "https://example.com/mixtapes/")
        XCTAssertEqual(metadata.items.count, 2)
        XCTAssertEqual(metadata.title, "Mixtapes")
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
