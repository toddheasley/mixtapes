import Foundation

struct HTMLPage: Resource {
    enum Page {
        case item(Item), index
        
        var item: Item? {
            switch self {
            case .item(let item): item
            default: nil
            }
        }
        
        var path: String {
            switch self {
            case .item(let item): item.id
            case .index: "index"
            }
        }
    }
    
    let page: Page
    
    init(_ page: Page, index: Index) {
        self.page = page
        url = URL(fileURLWithPath: "\(page.path).\(Self.html)", relativeTo: index.url)
        data = Self.document(page, index: index).data(using: .utf8)!
    }
    
    // MARK: Resource
    let data: Data
    let url: URL
}

extension HTMLPage {
    private static func document(_ page: Page, index: Index) -> String {
        ([
            "<!DOCTYPE html>"
        ] + head(page, index: index) + body(page, index: index)).joined(separator: "\n")
    }
    
    private static func head(_ page: Page, index: Index) -> [String] {
        [
            "<title>\(title(page, index: index))</title>",
            "<meta charset=\"UTF-8\">",
            "<meta name=\"viewport\" content=\"initial-scale=1.0\">",
            "<meta name=\"og:image\" content=\"\(image(page, index: index))\">",
            "<meta name=\"og:title\" content=\"\(title(page, index: index))\">",
            "<link rel=\"alternate\" href=\"\(RSSFeed(index: index).url.lastPathComponent)\" type=\"application/rss+xml\">",
            "<link rel=\"apple-touch-icon\" href=\"\(try! Bookmark(icon: index.icon).url.lastPathComponent)\">",
            "<link rel=\"shortcut icon\" href=\"\(try! Favicon(url: index.url).url.lastPathComponent)\">",
            "<link rel=\"stylesheet\" href=\"\(try! Stylesheet(url: index.url).url.lastPathComponent)\">"
        ]
    }
    
    private static func body(_ page: Page, index: Index) -> [String] {
        switch page {
        case .item(let item):
            return Self.item(item, index: index)
        case .index:
            return Self.index(index)
        }
    }
    
    private static func item(_ item: Item, index: Index) -> [String] {
        [
            "<h1><a href=\"index.html\">\(index.title)</a></h1>",
            "<p>\(image(item))</p>",
            "<p>\(audio(item))</p>",
            "<table>",
            "    <tr>",
            "        <td class=\"nowrap\">\(item.title) - \(item.summary)</td>",
            "        <td>\(item.attachment.asset.duration.timestamp)</td>",
            "    </tr>",
        ] + chapters(item) + [
            "</table>",
            "<p>\(authors(index).first ?? "")</p>"
        ]
    }
    
    private static func chapters(_ item: Item) -> [String] {
        guard !item.attachment.asset.chapters.isEmpty else { return [] }
        var chapters: [String] = [
            "    <tr>",
            "        <th colspan=\"2\">Chapters</th>",
            "    </tr>"
        ]
        for chapter in item.attachment.asset.chapters {
            chapters += [
                "    <tr>",
                "        <td class=\"nowrap\">\(chapter.title)</td>",
                "        <td>\(chapter.duration?.lowerBound.timestamp ?? "")</td>",
                "    </tr>"
            ]
        }
        return chapters
    }
    
    private static func index(_ index: Index) -> [String] {
        [
            "<h1>\(index.title)</h1>",
            "<p>\(index.items.map { link($0) }.joined(separator: " "))</p>",
            "<p>\(index.description) by \(authors(index).first ?? "")</p>",
            "<p>\(feed(index))</p>"
        ]
    }
    
    private static func link(_ item: Item) -> String {
        "<a href=\"\(item.id).\(html)\">\(image(item))</a>"
    }
    
    private static func feed(_ index: Index) -> String {
        "<a href=\"\(RSSFeed(index: index).url.lastPathComponent)\">Listen as a podcast</a>"
    }
    
    private static func authors(_ index: Index) -> [String] {
        index.authors.map { "<a href=\"\($0.url)\">\($0)</a>" }
    }
    
    private static func audio(_ item: Item) -> String {
        "<audio src=\"\(item.attachment.url.lastPathComponent)\" controls></audio>"
    }
    
    private static func image(_ index: Index) -> String {
        "<img src=\"\(index.iconURL?.lastPathComponent ?? (try! Icon(url: index.url).url.lastPathComponent))\" alt=\"\(index.title)\">"
    }
    
    private static func image(_ item: Item) -> String {
        "<img src=\"\(item.image.lastPathComponent)\" alt=\"\(title(item))\">"
    }
    
    private static func image(_ page: Page, index: Index) -> String {
        switch page {
        case .item(let item):
            guard let url: URL = index.itemURL(item)?.image else { fallthrough }
            return url.absoluteString
        default:
            return index.iconURL?.absoluteString ?? ""
        }
    }
    
    private static func title(_ page: Page, index: Index) -> String {
        page.item != nil ? "\(title(page.item)) - \(index.title)" : index.title
    }
    
    private static func title(_ item: Item?) -> String {
        (item?.title ?? "").replacingOccurrences(of: "\"", with: "")
    }
    
    private static let html: String = "html"
}
