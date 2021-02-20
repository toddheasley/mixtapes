import Foundation

struct HTMLPage: Resource {
    init(index: Index, item: Item? = nil) {
        url = URL(fileURLWithPath: "\(item?.id ?? index.id).html", relativeTo: index.url)
        data = Data()
    }
    
    // MARK: Resource
    public let url: URL
    public let data: Data
}

extension HTMLPage {
    private static func document(index: Index, item: Item?) -> String {
        var string: String = "<!DOCTYPE html>\n"
        string += "\(Self.head(index: index, item: item))\n"
        return string
    }
    
    private static func head(index: Index, item: Item?) -> String {
        var string: String = "<meta name=\"viewport\" content=\"initial-scale=1.0\">\n" // viewport-fit=cover?
        if let item: Item = item {
            string += "<title>\(item.title) - \(index.title)</title>\n"
        } else {
            string += "<title>\(index.title)</title>\n"
        }
        string += "<link rel=\"alternate\" href=\"\(RSSFeed(index: index).url.lastPathComponent)\" type=\"application/rss+xml\">\n"
        if let stylesheet: String = try? Stylesheet(url: index.url).url.lastPathComponent {
            string += "<link rel=\"stylesheet\" href=\"\(stylesheet)\">\n"
        }
        return string
    }
    
    private static func body(index: Index, item: Item?) -> String {
        var string: String = ""
        string += "\(Self.header(index: index, item: item))"
        string += "\(Self.main(index: index, item: item))"
        string += "\(Self.footer(index: index))"
        return string
    }
    
    private static func header(index: Index, item: Item?) -> String {
        var string: String = ""
        string += "<header>\n"
        string += "    <table>\n"
        string += "        <tr>\n"
        if let href: String = index.homepageURL?.lastPathComponent,
           item != nil {
            string += "            <td><h1><a href=\"\(href)\">\(index.title)</a></h1></td>\n"
        } else {
            string += "            <td><h1>\(index.title)</h1></td>\n"
        }
        string += "            <td><a href=\"\(RSSFeed(index: index).url.lastPathComponent)\"><img src=\"\" alt=\"\"></a></td>\n"
        string += "        </tr>\n"
        string += "    </table>\n"
        string += "</header>"
        return string
    }
    
    private static func main(index: Index, item: Item?) -> String {
        var string: String = "<main>\n"
        if let item: Item = item {
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
        } else {
            for (i, item) in index.items.enumerated() {
                
                if i > 0 {
                    string += "    <hr>\n"
                }
                string += "    <table>\n"
                string += "        <tr>\n"
                string += "            <td><a href=\"\(index.itemURL(item)?.link.lastPathComponent ?? "")\">\(item.title) - \(item.summary)</a></td>\n"
                string += "            <td><time>\(item.attachment.asset.duration.timestamp)</time></td>\n"
                string += "        </tr>\n"
                string += "    </table>\n"
            }
        }
        string += "</main>"
        return string
    }
    
    private static func footer(index: Index) -> String {
        var string: String = "<footer>\n"
        if !index.authors.isEmpty {
            string += "    <table>\n"
            for author in index.authors {
                string += "        <tr>\n"
                string += "            <td><a href=\"\(author.url.absoluteString)\">\(author)</a></td>\n"
                string += "        </tr>\n"
            }
            string += "    </table>\n"
        }
        string += "</footer>"
        return string
    }
}
