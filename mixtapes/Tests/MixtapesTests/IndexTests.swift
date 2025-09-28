import Testing
@testable import Mixtapes
import Foundation

struct IndexTests {
    @Test func homepage() async throws {
        var index: Index = try await Index(url: resources)
        index.homepage = ""
        #expect(index.homepageURL == nil)
        #expect(index.homepage == "")
        index.homepage = "https://example.com/mixtapes/"
        #expect(index.homepageURL == URL(homepage: "https://example.com/mixtapes/", path: "index.html"))
        #expect(index.homepage == "https://example.com/mixtapes/")
        index.homepage = ""
        #expect(index.homepageURL == nil)
        #expect(index.homepage == "")
    }
    
    @Test func urlInit() async throws {
        await #expect(throws: Error.self) {
            _ = try await Index(url: resources.appendingPathComponent("example"))
        }
        var index: Index = try await Index(url: resources)
        index.authors = [
            Author("Name", url: "mailto:name@example.com")
        ]
        index.homepage = "https://example.com"
        index.title = "Example"
        try index.write()
        index = try await Index(url: resources)
        #expect(index.authors.first?.name == "Name")
        #expect(index.authors.first?.url == "mailto:name@example.com")
        #expect(index.homepage == "https://example.com/")
        #expect(index.title == "Example")
    }
    
    @Test func feedURL() async throws {
        var index: Index = try await Index(url: resources)
        index.homepage = ""
        #expect(index.feedURL == nil)
        index.homepage = "https://example.com/mixtapes/"
        #expect(index.feedURL == URL(homepage: "https://example.com/mixtapes/", path: "index.json"))
    }
    
    @Test func iconURL() async throws {
        var index: Index = try await Index(url: resources)
        index.homepage = ""
        #expect(index.iconURL == nil)
        index.homepage = "https://example.com/mixtapes/"
        #expect(index.iconURL == URL(homepage: "https://example.com/mixtapes/", path: "icon.png"))
    }
}

extension IndexTests {
    
    // MARK: Codable
    @Test func encode() async throws {
        let decoder: JSONDecoder = JSONDecoder(url: URL(string: "index.json", relativeTo: resources)!)
        let encoder: JSONEncoder = JSONEncoder(url: URL(string: "https://example.com/mixtapes/")!, formatting: [.sortedKeys])
        let metadata: Index.Metadata = try decoder.decode(Index.Metadata.self, from: IndexTests_Data)
        let index: Index = try await Index(metadata: metadata)
        let data: Data = try encoder.encode(index)
        let mock: IndexTests_Mock = try decoder.decode(IndexTests_Mock.self, from: IndexTests_Data)
        let mockData: Data = try encoder.encode(mock)
        #expect(data == mockData)
    }
    
    @Test func metadataDecoderInit() throws {
        let metadata: Index.Metadata = try JSONDecoder(url: URL(string: "index.json", relativeTo: resources)!).decode(Index.Metadata.self, from: IndexTests_Data)
        #expect(metadata.authors.first?.name == "Todd Heasley")
        #expect(metadata.authors.first?.url == "mailto:toddheasley@me.com")
        #expect(metadata.authors.count == 1)
        #expect(metadata.description == "Example mixtapes podcast")
        #expect(metadata.homepage == "https://example.com/mixtapes/")
        #expect(metadata.items.count == 2)
        #expect(metadata.title == "Mixtapes")
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
                    "url": "example.m4a"
                }
            ],
            "date_published": "1970-01-01T00:00:01Z",
            "id": "example",
            "image": "example.png",
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
                    "url": "example.mp3"
                }
            ],
            "date_published": "1970-01-01T00:00:00Z",
            "id": "example",
            "image": "example.jpg",
            "summary": "Artist",
            "title": "Album"
        }
    ],
    "title": "Mixtapes",
    "version": "https://jsonfeed.org/version/1.1"
}
""".data(using: .utf8)!
