import Foundation

struct HTMLPage: Resource {
    init(index: Index, item: Item? = nil) {
        url = URL(fileURLWithPath: "\(item?.id ?? index.id).html", relativeTo: index.url)
        data = Self.document(index: index, item: item).data(using: .utf8)!
    }
    
    // MARK: Resource
    public let data: Data
    public let url: URL
}

extension HTMLPage {
    private static func document(index: Index, item: Item? = nil) -> String {
        var string: String = "<!DOCTYPE html>\n"
        string += "\(Self.head(index: index, item: item))\n"
        string += "\(self.body(index: index, item: item))"
        return string
    }
    
    private static func head(index: Index, item: Item? = nil) -> String {
        var title: String {
            guard let item: Item = item else {
                return index.title
            }
            return "\(item.title) - \(index.title)"
        }
        
        var string: String = ""
        string += "<title>\(title)</title>\n"
        string += "<meta name=\"viewport\" content=\"initial-scale=1.0\">\n"
        if let item: Item = item, let imageURL: URL = index.itemURL(item)?.image {
            string += "<meta name=\"og:image\" content=\"\(imageURL.absoluteString)\">\n"
        } else if let iconURL: URL = index.iconURL {
            string += "<meta name=\"og:image\" content=\"\(iconURL.absoluteString)\">\n"
        }
        string += "<meta name=\"og:title\" content=\"\(title)\">\n"
        string += "<link rel=\"alternate\" href=\"\(RSSFeed(index: index).url.lastPathComponent)\" type=\"application/rss+xml\">\n"
        if let bookmark: Bookmark = try? Bookmark(icon: index.icon) {
            string += "<link rel=\"apple-touch-icon\" href=\"\(bookmark.url.lastPathComponent)\">\n"
        }
        if let favicon: Favicon = try? Favicon(url: index.url) {
            string += "<link rel=\"shortcut icon\" href=\"\(favicon.url.lastPathComponent)\">\n"
        }
        string += "<link rel=\"stylesheet\" href=\"\(try! Stylesheet(url: index.url).url.lastPathComponent)\">"
        return string
    }
    
    private static func body(index: Index, item: Item? = nil) -> String {
        var string: String = ""
        string += "\(Self.nav(index: index, item: item))\n"
        string += "\(Self.article(index: index, item: item))"
        return string
    }
    
    private static func nav(index: Index, item: Item? = nil) -> String {
        var string: String = ""
        string += "<nav>\n"
        string += "    <table>\n"
        string += "        <tr>\n"
        string += "            <td><a href=\"\(RSSFeed(index: index).url.lastPathComponent)\"><img src=\"\(try! RSSIcon(url: index.url).url.lastPathComponent)\" alt=\"Subscribe\"></a></td>\n"
        if let homepageURL: URL = index.homepageURL, item != nil {
            string += "            <td><a href=\"\(homepageURL.lastPathComponent)\">\(index.title)</a></td>\n"
        } else {
            string += "            <td>\(index.title)</td>\n"
        }
        string += "        </tr>\n"
        string += "    </table>\n"
        string += "</nav>"
        return string
    }
    
    private static func article(index: Index, item: Item? = nil) -> String {
        var string: String = ""
        string += "<article>\n"
        if let item: Item = item ?? index.items.first {
            string += "    <figure><img src=\"\(item.image.lastPathComponent)\"></figure>\n"
            string += "    <hr>\n"
            string += "    <table>\n"
            string += "        <tr>\n"
            string += "            <td>\(item.title) - \(item.summary)</td>\n"
            string += "            <td><time>\(item.attachment.asset.duration.timestamp)</time></td>\n"
            string += "        </tr>\n"
            string += "    </table>\n"
            string += "    <hr>\n"
            string += "    <table>\n"
            string += "        <tr>\n"
            string += "            <td><audio preload=\"metadata\" controls><source src=\"\(item.attachment.url.lastPathComponent)\" type=\"\(item.attachment.mimeType)\"></audio></td>\n"
            string += "        </tr>\n"
            string += "    </table>\n"
            if !item.attachment.asset.chapters.isEmpty {
                string += "    <table>\n"
                string += "        <tr>\n"
                string += "            <th colspan=\"2\">Chapters</th>\n"
                string += "        </tr>\n"
                for chapter in item.attachment.asset.chapters {
                    string += "        <tr>\n"
                    string += "            <td colspan=\"2\"><hr></td>\n"
                    string += "        </tr>\n"
                    string += "        <tr>\n"
                    string += "            <td>\(chapter.title)</td>\n"
                    string += "            <td><time>\(chapter.duration?.lowerBound.timestamp ?? "")</time></td>\n"
                    string += "        </tr>\n"
                }
                string += "    </table>\n"
            }
            if let author: Author = index.authors.first {
                string += "    <table>\n"
                string += "        <tr>\n"
                string += "            <td><a href=\"\(author.url)\">\(author)</a></td>\n"
                string += "        </tr>\n"
                string += "    </table>\n"
            }
        }
        if index.items.count > 1, item == nil {
            string += "    <hr>\n"
            string += "    <table>\n"
            string += "        <tr>\n"
            string += "            <th colspan=\"2\">Index</th>\n"
            string += "        </tr>\n"
            for item in index.items {
                string += "        <tr>\n"
                string += "            <td colspan=\"2\"><hr></td>\n"
                string += "        </tr>\n"
                string += "        <tr>\n"
                if let linkURL: URL = index.itemURL(item)?.link {
                    string += "            <td><a href=\"\(linkURL.lastPathComponent)\">\(item.title) - \(item.summary)</a></td>\n"
                } else {
                    string += "            <td>\(item.title) - \(item.summary)</td>\n"
                }
                string += "            <td><time>\(item.attachment.asset.duration.timestamp)</time></td>\n"
                string += "        </tr>\n"
            }
            string += "    </table>\n"
        }
        string += "</article>"
        return string
    }
}
