import Foundation

public class HTML: Resource {
    static func data(index: Index, item: Item? = nil) -> Data {
        return document(index: index, item: item).data(using: .utf8)!
    }
    
    public init(index: Index) {
        var resources: [Resource] = [
            SVG(name: .rss, url: index.url),
            Stylesheet(url: index.url)
        ]
        for item in index.items {
            resources.append(Resource(url: URL(fileURLFor: item, relativeTo: index.url), data: Self.data(index: index, item: item)))
        }
        super.init(url: URL(fileURLRelativeTo: index.url), data: Self.data(index: index), resources: resources)
    }
}

extension HTML {
    private static func document(index: Index, item: Item?) -> String {
        var string: String = ""
        string.append(string: "<!DOCTYPE html>", after: "")
        string.append(string: head(index: index, item: item))
        string.append(string: body(index: index, item: item))
        return string
    }
    
    private static func head(index: Index, item: Item?) -> String {
        var string: String = ""
        string.append(string: "<head>", after: "")
        if let item: Item = item {
            string.append(string: "<title>\(item.title) - \(index.title)</title>", indent: "    ")
        } else {
            string.append(string: "<title>\(index.title)</title>", indent: "    ")
        }
        string.append(string: "<meta name=\"viewport\" content=\"initial-scale=1.0, viewport-fit=cover\">", indent: "    ")
        string.append(string: "<link rel=\"alternate\" href=\"\(URL(string: "index.rss", relativeTo: index.homepage)!.absoluteString)\" type=\"application/rss+xml\" title=\"RSS\">", indent: "    ")
        if let icon: Resource = index.icon {
            string.append(string: "<link rel=\"apple-touch-icon\" href=\"\(URL(string: icon.url.relativePath, relativeTo: index.homepage)!.absoluteString)\">", indent: "    ")
        }
        string.append(string: "<link rel=\"stylesheet\" href=\"\(Stylesheet(url: index.homepage).url.relativePath)\">", indent: "    ")
        string.append(string: "</head>")
        return string
    }
    
    private static func body(index: Index, item: Item?) -> String {
        var string: String = ""
        string.append(string: "<body>", after: "")
        string.append(string: header(index: index, item: item), indent: "    ")
        string.append(string: main(index: index, item: item), indent: "    ")
        string.append(string: footer(index: index), indent: "    ")
        string.append(string: "</body>")
        return string
    }
    
    private static func header(index: Index, item: Item?) -> String {
        var string: String = ""
        string.append(string: "<header>", after: "")
        string.append(string: "    <table>")
        string.append(string: "        <tr>")
        if let _: Item = item {
            string.append(string: "            <td><h1><a href=\"\(URL(fileURLRelativeTo: index.homepage).relativePath)\">\(index.title)</a></h1></td>")
        } else {
            string.append(string: "            <td><h1>\(index.title)</h1></td>")
        }
        string.append(string: "            <td><a href=\"index.rss\"><img src=\"\(SVG(name: .rss, url: index.homepage).url.relativePath)\" alt=\"RSS\"></a></td>")
        string.append(string: "        </tr>")
        string.append(string: "    </table>")
        string.append(string: "</header>")
        return string
    }
    
    private static func main(index: Index, item: Item?) -> String {
        var string: String = ""
        string.append(string: "<main>", after: "")
        if let item: Item = item {
            string.append(string: "    <figure><img src=\"\(item.image.relativePath)\"></figure>")
            string.append(string: "    <hr>")
            string.append(string: "    <table>")
            string.append(string: "        <tr>")
            string.append(string: "            <td>\(item.title) - \(item.summary)</td>")
            string.append(string: "            <td><time>\(item.attachment.asset.duration.description)</time></td>")
            string.append(string: "        </tr>")
            string.append(string: "    </table>")
            string.append(string: "    <hr>")
            string.append(string: "    <table>")
            string.append(string: "        <tr>")
            string.append(string: "            <td><audio preload=\"metadata\" controls><source src=\"\(item.attachment.url.relativePath)\" type=\"\(item.attachment.mimeType)\"></audio></td>")
            string.append(string: "        </tr>")
            string.append(string: "    </table>")
            if !item.attachment.asset.chapters.isEmpty {
                string.append(string: "    <table>")
                string.append(string: "        <tr>")
                string.append(string: "            <th colspan=\"2\">Chapters</th>")
                string.append(string: "        </tr>")
                for chapter in item.attachment.asset.chapters {
                    string.append(string: "        <tr>")
                    string.append(string: "            <td colspan=\"2\"><hr></td>")
                    string.append(string: "        </tr>")
                    string.append(string: "        <tr>")
                    string.append(string: "            <td>\(chapter.title)</td>")
                    string.append(string: "            <td><time>\(chapter.duration.lowerBound.description)</time></td>")
                    string.append(string: "        </tr>")
                }
                string.append(string: "    </table>")
            }
        } else {
            for (i, item) in index.items.enumerated() {
                if i != 0 {
                    string.append(string: "    <hr>")
                }
                string.append(string: "    <table>")
                string.append(string: "        <tr>")
                string.append(string: "            <td><a href=\"\(URL(fileURLFor: item, relativeTo: index.url).relativePath)\">\(item.title) - \(item.summary)</a></td>")
                string.append(string: "            <td><time>\(item.attachment.asset.duration.description)</time></td>")
                string.append(string: "        </tr>")
                string.append(string: "    </table>")
            }
        }
        string.append(string: "</main>")
        return string
    }
    
    private static func footer(index: Index) -> String {
        var string: String = ""
        string.append(string: "<footer>", after: "")
        if let author: Author = index.author {
            string.append(string: "    <table>")
            string.append(string: "        <tr>")
            string.append(string: "            <td><a href=\"\(author.url.absoluteString)\">\(author.description)</a></td>")
            string.append(string: "        </td>")
            string.append(string: "    </table>")
        }
        string.append(string: "</footer>")
        return string
    }
}

extension String {
    fileprivate mutating func append(string: String, after line: String = "\n", indent: String = "") {
        let string: String = string.components(separatedBy: "\n").map { string in
            return "\(indent)\(string)"
        }.joined(separator: "\n")
        self = "\(self)\(line)\(string)"
    }
}

extension URL {
    fileprivate static let pathExtension: String = "html"
    
    fileprivate init(fileURLFor item: Item, relativeTo url: URL) {
        self = URL(fileURLWithPath: item.attachment.url.relativePath.replacingOccurrences(of: ".\(Asset.pathExtension)", with: ".\(Self.pathExtension)"), relativeTo: url)
    }
    
    fileprivate init(fileURLRelativeTo url: URL) {
        self = URL(fileURLWithPath: "index.\(Self.pathExtension)", relativeTo: url)
    }
}
