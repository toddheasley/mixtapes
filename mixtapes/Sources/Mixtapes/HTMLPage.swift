import Foundation

struct HTMLPage: Resource {
    enum Page {
        case item(Item), index, promo
        
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
            case .promo: "promo"
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
            "<link rel=\"alternate\" href=\"\(RSSFeed(index: index).url.lastPathComponent)\" type=\"application/rss+xml\">",
            "<link rel=\"apple-touch-icon\" href=\"\(try! Bookmark(icon: index.icon).url.lastPathComponent)\">",
            "<link rel=\"shortcut icon\" href=\"\(try! Favicon(url: index.url).url.lastPathComponent)\">",
            "<link rel=\"stylesheet\" href=\"\(try! Stylesheet(url: index.url).url.lastPathComponent)\">"
        ]
    }
    
    private static func body(_ page: Page, index: Index) -> [String] {
        var strings: [String] = []
        switch page {
        case .item(let item):
            strings += [
                "<h1><a href=\"\(index.id).\(html)\">\(index.title)</a> \(feed(index))</h1>"
            ] + Self.item(item, index: index) + authors(index)
        case .index:
            strings += [
                "<h1>\(index.title) \(feed(index))</h1>"
            ] + Self.index(index) + authors(index)
        case .promo:
            strings += [
                "<h4><a href=\"\(index.id).\(html)\" target=\"_parent\">\(index.title)</a></h4>"
            ] + promo(index)
        }
        return strings
    }
    
    private static func item(_ item: Item, index: Index) -> [String] {
        [
            "<article>",
            "    <table>",
            "        <tr>",
            "            <td colspan=\"2\">\(image(item))</td>",
            "        </tr>",
            "        <tr>",
            "            <td colspan=\"2\">\(audio(item))</td>",
            "        </tr>",
            "        <tr>",
            "            <td>\(item.title) - \(item.summary)</td>",
            "            <td>\(item.attachment.asset.duration.timestamp)</td>",
            "        </tr>",
            "    </table>"
        ] + chapters(item) + [
            "</article>"
        ]
    }
    
    private static func chapters(_ item: Item) -> [String] {
        guard !item.attachment.asset.chapters.isEmpty else { return [] }
        var chapters: [String] = [
            "    <table>",
            "        <tr>",
            "            <th colspan=\"2\">Chapters</th>",
            "        </tr>"
        ]
        for chapter in item.attachment.asset.chapters {
            chapters += [
                "        <tr>",
                "            <td>\(chapter.title)</td>",
                "            <td>\(chapter.duration?.lowerBound.timestamp ?? "")</td>",
                "        </tr>"
            ]
        }
        chapters += [
            "    </table>"
        ]
        return chapters
    }
    
    private static func index(_ index: Index) -> [String] {
        [
            "<ul>",
        ] + index.items.map { item in
            "    <li><a href=\"\(item.id).\(html)\">\(image(item))</a></li>"
        } + [
            "</ul>"
        ]
    }
    
    private static func promo(_ index: Index) -> [String] {
        [
            "<table>",
            "    <tr>"
        ] + index.items.prefix(10).map { item in
            "        <td><a href=\"\(item.id).\(html)\" target=\"_parent\">\(image(item))</a></td>"
        } + [
            "    </tr>",
            "</table>"
        ]
    }
    
    private static func authors(_ index: Index) -> [String] {
        index.authors.map { "<p><a href=\"\($0.url)\">\($0)</a></p>" }
    }
    
    private static func feed(_ index: Index) -> String {
        "<a href=\"\(RSSFeed(index: index).url.lastPathComponent)\">\(feedIcon(index))</a>"
    }
    
    private static func feedIcon(_ index: Index) -> String {
        "<img src=\"\(try! RSSIcon(url: index.url).url.lastPathComponent)\" alt=\"Podcast Feed\">"
    }
    
    private static func audio(_ item: Item) -> String {
        "<audio src=\"\(item.attachment.url.lastPathComponent)\" controls></audio>"
    }
    
    private static func image(_ item: Item) -> String {
        "<img src=\"\(item.image.lastPathComponent)\" alt=\"Album Artwork: \(title(item))\">"
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
