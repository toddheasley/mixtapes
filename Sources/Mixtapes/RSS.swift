import Foundation

public class RSS: Resource {
    public init(index: Index) {
        let dateFormatter: DateFormatter = DateFormatter(format: .rfc822)
        var string: String = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n"
        string += "<rss version=\"2.0\" xmlns:itunes=\"http://www.itunes.com/dtds/podcast-1.0.dtd\">\n"
        string += "    <channel>\n"
        string += "        <title>\(index.title)</title>\n"
        if let description: String = index.description {
            string += "        <description>\(description)</description>\n"
        }
        string += "        <link>\(URL(fileURLWithPath: "index.html", relativeTo: index.homepage).absoluteString)</link>\n"
        string += "        <lastBuildDate>\(dateFormatter.string(from: Date()))</lastBuildDate>\n"
        if let icon: Resource = index.icon {
            string += "        <itunes:image href=\"\(URL(fileURLWithPath: icon.url.relativePath, relativeTo: index.homepage).absoluteString)\" />\n"
        }
        if let description: String = index.description {
            string += "        <itunes:summary>\(description)</itunes:summary>\n"
        }
        if let author: Author = index.author {
            string += "        <itunes:author>\(author)</itunes:author>\n"
        }
        for item in index.items {
            string += "        <item>\n"
            string += "            <title>\(item.title)</title>\n"
            string += "            <description>\(item.summary)</description>\n"
            string += "            <guid isPermaLink=\"false\">\(item.id)</guid>\n"
            string += "            <link>\(URL(fileURLWithPath: item.attachment.url.relativePath, relativeTo: index.homepage).absoluteString)</link>\n"
            string += "            <pubDate>\(dateFormatter.string(from: item.date.published))</pubDate>\n"
            string += "            <enclosure url=\"\(URL(fileURLWithPath: item.attachment.url.relativePath, relativeTo: index.homepage).absoluteString)\" length=\"\(item.attachment.sizeInBytes)\" type=\"\(item.attachment.mimeType)\" />\n"
            string += "            <itunes:image href=\"\(URL(fileURLWithPath: item.image.relativePath, relativeTo: index.homepage).absoluteString)\" />\n"
            string += "            <itunes:duration>\(item.attachment.durationInSeconds)</itunes:duration>\n"
            if item.isExplicit {
                string += "            <itunes:explicit>yes</itunes:explicit>\n"
            }
            string += "        </item>\n"
        }
        string += "    </channel>\n"
        string += "</rss>"
        super.init(url: URL(fileURLWithPath: "index.rss", relativeTo: index.url), data: string.data(using: .utf8)!)
    }
}
