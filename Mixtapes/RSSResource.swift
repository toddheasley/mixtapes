import Foundation

public class RSSResource: Resource {
    public init(index: Index) {
        var string: String = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
        string += "<rss version=\"2.0\" xmlns:itunes=\"http://www.itunes.com/dtds/podcast-1.0.dtd\">\n"
        string += "    <channel>\n"
        string += "        <title>\(index.title)</title>\n"
        string += "        <description>\(index.description)</description>\n"
        string += "        <link>\(index.link.absoluteString)</link>\n"
        string += "        <itunes:image href=\"\(index.link.appendingPathComponent(index.artwork.url.relativePath).absoluteString)\" />\n"
        string += "        <itunes:summary>\(index.description)</itunes:summary>\n"
        string += "        <itunes:author>\(index.author.description)</itunes:author>\n"
        for asset in index.assets {
            string += "        <item>\n"
            string += "            <title>\(asset.title)</title>\n"
            string += "            <description>\(asset.artist)</description>\n"
            string += "            <guid isPermaLink=\"false\">\(asset.guid)</guid>\n"
            string += "            <link>\(index.link.appendingPathComponent(asset.url.relativePath).absoluteString)</link>\n"
            string += "            <enclosure url=\"\(index.link.appendingPathComponent(asset.url.relativePath).absoluteString)\" length=\"\(asset.length)\" type=\"audio/mpeg\" />\n"
            string += "            <itunes:image href=\"\(index.link.appendingPathComponent(asset.artwork.url.relativePath).absoluteString)\" />\n"
            string += "            <itunes:duration>\(Int(asset.duration))</itunes:duration>\n"
            string += "            <itunes:explicit>yes</itunes:explicit>\n"
            string += "        </item>\n"
        }
        string += "    </channel>\n"
        string += "</rss>"
        super.init(url: URL(fileURLWithPath: index.url.relativePath.replacingOccurrences(of: ".txt", with: ".rss"), relativeTo: index.url.baseURL!), data: string.data(using: .utf8)!)
    }
}
