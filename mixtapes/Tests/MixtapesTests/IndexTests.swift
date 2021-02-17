import XCTest
@testable import Mixtapes

final class IndexTests: XCTestCase {
    func testFeedURL() {
        
    }
    
    func testIconURL() {
        
    }
}

extension IndexTests {
    
    // MARK: Codable
    func testEncode() throws {
        
    }
    
    func testDecoderInit() throws {
        
    }
}

private let IndexTests_Data: Data = """
{
    "author": {
        "name": "@toddheasley",
        "url": "https://github.com/toddheasley"
    },
    "description": "Love letters to my favorite music",
    "feed_url": "https://example.com/mixtapes//index.json",
    "home_page_url": "https://example.com/mixtapes/",
    "icon": "https://example.com/mixtapes//icon.jpg",
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
            "date_published": "1970-01-01T00:00:00Z",
            "id": "example",
            "image": "https://example.com/mixtapes/example.png",
            "summary": "Artist",
            "tags": [
                "explicit"
            ],
            "title": "Album"
        }
    ],
    "title": "Todd's Mixtapes",
    "version": "https://jsonfeed.org/version/1.1"
}
""".data(using: .utf8)!
