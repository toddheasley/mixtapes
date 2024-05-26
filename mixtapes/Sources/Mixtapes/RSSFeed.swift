import Foundation

struct RSSFeed: Resource {
    init(index: Index) {
        url = URL(fileURLWithPath: "\(index.id).rss", relativeTo: index.url)
        let dateFormatter: DateFormatter = .rfc822
        var string: String = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n"
        string += "<rss version=\"2.0\" xmlns:itunes=\"http://www.itunes.com/dtds/podcast-1.0.dtd\">\n"
        string += "    <channel>\n"
        string += "        <title>\(index.title)</title>\n"
        string += "        <description>\(index.description)</description>\n"
        if let homepageURL: URL = index.homepageURL {
            string += "        <link>\(homepageURL.absoluteString)</link>\n"
        }
        string += "        <lastBuildDate>\(dateFormatter.string(from: Date()))</lastBuildDate>\n"
        if let iconURL: URL = index.iconURL {
            string += "        <itunes:image href=\"\(iconURL.absoluteString)\" />\n"
        }
        string += "        <itunes:summary>\(index.description)</itunes:summary>\n"
        if let author: Author = index.authors.first {
            string += "        <itunes:author>\(author)</itunes:author>\n"
        }
        for item in index.items {
            guard let itemURL: (attachment: URL, image: URL, link: URL) = index.itemURL(item) else {
                continue
            }
            string += "        <item>\n"
            string += "            <title>\(item.title)</title>\n"
            string += "            <description>\(item.summary)</description>\n"
            string += "            <guid isPermaLink=\"false\">\(item.id)</guid>\n"
            string += "            <link>\(itemURL.link.absoluteString)</link>\n"
            string += "            <pubDate>\(dateFormatter.string(from: item.metadata.published))</pubDate>\n"
            string += "            <enclosure url=\"\(itemURL.attachment.absoluteString)\" length=\"\(item.attachment.sizeInBytes)\" type=\"\(item.attachment.mimeType)\" />\n"
            string += "            <itunes:image href=\"\(itemURL.image.absoluteString)\" />\n"
            string += "            <itunes:duration>\(item.attachment.durationInSeconds)</itunes:duration>\n"
            if item.metadata.isExplicit {
                string += "            <itunes:explicit>yes</itunes:explicit>\n"
            }
            string += "        </item>\n"
        }
        string += "    </channel>\n"
        string += "</rss>"
        data = string.data(using: .utf8)!
    }
    
    // MARK: Resource
    let data: Data
    let url: URL
}
