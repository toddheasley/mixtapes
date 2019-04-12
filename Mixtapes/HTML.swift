import Foundation

public class HTMLResource: Resource {
    public init(index: Index) {
        let svg: Resource = Resource(url: URL(fileURLWithPath: "rss.svg", relativeTo: index.url.baseURL!), data: _svg.data(using: .utf8)!)
        let rss: RSSResource = RSSResource(index: index)
        let css: CSSResource = CSSResource(index: index)
        var html: String = "<!DOCTYPE html>\n"
        html += "<title>\(index.title)</title>\n"
        html += "<meta name=\"viewport\" content=\"initial-scale=1.0, viewport-fit=cover\">\n"
        html += "<link rel=\"alternate\" href=\"\(index.link.appendingPathComponent(rss.url.relativePath).absoluteString)\" type=\"application/rss+xml\" title=\"RSS\">\n"
        html += "<link rel=\"apple-touch-icon\" href=\"\(index.artwork.url.relativePath)\">\n"
        html += "<link rel=\"stylesheet\" href=\"\(css.url.relativePath)\">\n"
        html += "<header>\n"
        html += "    <section>\n"
        html += "        <nav><a href=\"\(rss.url.relativePath)\"><img src=\"\(svg.url.relativePath)\" alt=\"RSS\"></a></nav>\n"
        html += "        <h1>\(index.title)</h1>\n"
        html += "        <hr>\n"
        html += "    </section>\n"
        html += "</header>\n"
        html += "<main>\n"
        for asset in index.assets {
            html += "    <table>\n"
            html += "        <tr>\n"
            html += "            <td colspan=\"3\"><audio preload=\"metadata\" controls><source src=\"\(asset.url.relativePath)\" type=\"audio/mpeg\"></audio></td>\n"
            html += "        </tr>\n"
            html += "        <tr>\n"
            html += "            <td rowspan=\"\(asset.chapters.count + 4)\"><img src=\"\(asset.artwork.url.relativePath)\"></td>\n"
            html += "            <td colspan=\"2\"><b>\(asset.title)</b></td>\n"
            html += "        </tr>\n"
            html += "        <tr>\n"
            html += "            <td><em>\(asset.artist)</em></td>\n"
            html += "            <td><time>\(asset.duration.description)</time></td>\n"
            html += "        </tr>\n"
            html += "        <tr>\n"
            html += "            <td colspan=\"2\"><small>Chapters</small></td>\n"
            html += "        </tr>\n"
            for chapter in asset.chapters {
                html += "        <tr>\n"
                html += "            <td>\(chapter.title)</td>\n"
                html += "            <td><time>\(chapter.duration.lowerBound.description)</time></td>\n"
                html += "        </tr>\n"
            }
            html += "        <tr>\n"
            html += "            <td colspan=\"2\"></td>\n"
            html += "        </tr>\n"
            html += "    </table>\n"
            html += "    <hr>\n"
        }
        html += "</main>\n"
        html += "<footer>\n"
        html += "    <p><small>Subscribe</small> <code>\(index.link.appendingPathComponent(rss.url.relativePath).absoluteString)</code></p>\n"
        html += "    <p><a href=\"\(index.author.url.absoluteString)\">\(index.author.description)</a></p>\n"
        html += "</footer>"
        super.init(url: URL(fileURLWithPath: index.url.relativePath.replacingOccurrences(of: ".txt", with: ".html"), relativeTo: index.url.baseURL!), data: html.data(using: .utf8)!, resources: [svg, rss, css])
    }
}

private let _svg: String = """
<?xml version="1.0" encoding="UTF-8"?>
<svg width="60px" height="60px" viewBox="0 0 60 60" version="1.1" xmlns="http://www.w3.org/2000/svg">
    <title>RSS</title>
    <rect fill="rgb(243, 78, 63)" x="0" y="0" width="60" height="60"></rect>
    <path fill="rgb(242, 242, 242)" d="M63,62.7532808 C63,66.2073491 60.1951006,69 56.7532808,69 C53.3114611,69 50.5065617,66.1951006 50.5065617,62.7532808 C50.5065617,34.4470691 27.5529309,11.4934383 -0.75328084,11.4934383 C-4.20734908,11.4934383 -7,8.68853893 -7,5.24671916 C-7,1.80489939 -4.19510061,-1 -0.75328084,-1 C17.8031496,-1 33.0279965,5.40594926 44.9825022,17.3604549 C57.2309711,29.5966754 63,44.7970254 63,62.7532808 Z M33.8189789,69 C30.4012378,69 27.6379577,66.2246007 27.6379577,62.8189796 C27.6379577,47.1119162 14.9002063,34.3620467 -0.818978855,34.3620467 C-4.23671996,34.3620467 -7,31.5866474 -7,28.1810264 C-7,24.7632857 -4.22460031,22.000006 -0.818978855,22.000006 C21.7114492,21.9878864 40,40.2764348 40,62.8189796 C40,66.2367203 37.2246003,69 33.8189789,69 Z M-7,57.5 C-7,51.1430903 -1.86942329,46 4.5,46 C10.8694233,46 16,51.1305767 16,57.5 C16,63.8569097 10.8694233,69 4.5,69 C-1.86942329,69 -7,63.8569097 -7,57.5 Z"></path>
    <rect fill="rgb(44, 44, 44)" x="0" y="0" width="32" height="16"></rect>
    <text fill="rgb(236, 236, 236)" font-family="sans-serif" font-size="12" font-weight="bold">
        <tspan x="3.75" y="12">RSS</tspan>
    </text>
</svg>
"""
