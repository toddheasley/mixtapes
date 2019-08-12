import Foundation

public class HTML: Resource {
    public init(index: Index) {
        let rssIcon: Resource = Resource(url: URL(fileURLWithPath: "rss.svg", relativeTo: index.url), data: RSSIcon)
        let gaeguFont: Resource = Resource(url: URL(fileURLWithPath: "gaegu.woff", relativeTo: index.url), data: GaeguFont)
        let stylesheet: Resource = Resource(url: URL(fileURLWithPath: "stylesheet.css", relativeTo: index.url), data: Stylesheet)
        var html: String = "<!DOCTYPE html>\n"
        html += "<title>\(index.title)</title>\n"
        html += "<meta name=\"viewport\" content=\"initial-scale=1.0, viewport-fit=cover\">\n"
        html += "<link rel=\"alternate\" href=\"\(URL(fileURLWithPath: "index.rss", relativeTo: index.homepage).absoluteString)\" type=\"application/rss+xml\" title=\"RSS\">\n"
        if let icon: Resource = index.icon {
            html += "<link rel=\"apple-touch-icon\" href=\"\(icon.url.relativePath)\">\n"
        }
        html += "<link rel=\"stylesheet\" href=\"\(stylesheet.url.relativePath)\">\n"
        html += "<header>\n"
        html += "    <section>\n"
        html += "        <nav><a href=\"index.rss\"><img src=\"\(rssIcon.url.relativePath)\" alt=\"RSS\"></a></nav>\n"
        html += "        <h1>\(index.title)</h1>\n"
        html += "        <hr>\n"
        html += "    </section>\n"
        html += "</header>\n"
        html += "<main>\n"
        for item in index.items {
            html += "    <table>\n"
            html += "        <tr>\n"
            html += "            <td colspan=\"3\"><audio preload=\"metadata\" controls><source src=\"\(item.attachment.url.relativePath)\" type=\"\(item.attachment.mimeType)\"></audio></td>\n"
            html += "        </tr>\n"
            html += "        <tr>\n"
            html += "            <td rowspan=\"\(item.attachment.asset.chapters.count + 4)\"><img src=\"\(item.image.relativePath)\"></td>\n"
            html += "            <td colspan=\"2\"><b>\(item.title)</b></td>\n"
            html += "        </tr>\n"
            html += "        <tr>\n"
            html += "            <td><em>\(item.summary)</em></td>\n"
            html += "            <td><time>\(item.attachment.asset.duration)</time></td>\n"
            html += "        </tr>\n"
            html += "        <tr>\n"
            html += "            <td colspan=\"2\"><small>Chapters</small></td>\n"
            html += "        </tr>\n"
            for chapter in item.attachment.asset.chapters {
                html += "        <tr>\n"
                html += "            <td>\(chapter.title)</td>\n"
                html += "            <td><time>\(chapter.duration.lowerBound)</time></td>\n"
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
        html += "    <p><small>Subscribe</small> <code>\(URL(fileURLWithPath: "index.rss", relativeTo: index.homepage).absoluteString)</code></p>\n"
        if let author: Author = index.author {
            html += "    <p><a href=\"\(author.url.absoluteString)\">\(author.description)</a></p>\n"
        }
        html += "</footer>"
        super.init(url: URL(fileURLWithPath: "index.html", relativeTo: index.url), data: html.data(using: .utf8)!, resources: [rssIcon, gaeguFont, stylesheet])
    }
}

private let RSSIcon: Data = """
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
""".data(using: .utf8)!

private let GaeguFont: Data = Data(base64Encoded: """
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
""")!

private let Stylesheet: Data = """
@font-face {
    font-family: "gaegu";
    font-style: normal;
    font-weight: normal;
    src: url("gaegu.woff") format("woff");
}

:root {
    --background: rgb(251, 251, 251);
    --color: rgb(37, 62, 148);
    --utility: rgba(44, 44, 44, 0.8);

    --hand: "gaegu";
    --sans: sans-serif;

    --head: 20px;
    --body: 16px;
    --meta: 10px;
}

* {
    -webkit-text-size-adjust: 100%;
    margin: 0;
    padding: 0;
}

a {
    color: inherit;
    text-decoration: none;
}

audio, img {
    display: block;
}

body {
    background: var(--background);
    color: var(--color);
    font: var(--body) var(--hand);
}

footer, header section, main {
    margin: 0 auto;
    max-width: 720px;
    padding-left: 12px;
    padding-right: 12px;
}

footer {
    padding-bottom: 44px;
}

footer code {
    display: block;
    font: 13px var(--hand);
    margin: 2px 0 16px 0;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

header {
    background: var(--background);
    position: fixed;
    width: 100%;
    z-index: 999;
}

header nav {
    border-bottom-left-radius: 2px;
    border-bottom-right-radius: 2px;
    overflow: hidden;
    position: absolute;
    right: 13px;
}

header section {
    position: relative;
}

header section h1 {
    display: table-cell;
    height: 60px;
    padding: 0 6px;
    text-transform: uppercase;
    vertical-align: middle;
}

hr {
    opacity: 0.3;
}

main {
    padding-top: 80px;
}

main hr {
    margin-top: 16px;
    margin-bottom: 16px;
}

small {
    color: var(--utility);
    display: block;
    font: bold var(--meta) var(--sans);
    text-transform: uppercase;
}

table, table audio {
    width: 100%;
}

table img {
    border: 1px solid rgba(132, 132, 132, 0.1);
    border-radius: 3px;
    width: 98%;
}

td {
    border-top: 2px dotted var(--utility);
    max-width: 0;
    overflow: hidden;
    padding: 3px 0 1px 0;
    text-overflow: ellipsis;
    vertical-align: top;
    white-space: nowrap;
}

td[rowspan] {
    border: 0;
    padding-right: 12px;
    width: 210px;
}

td[colspan="3"] {
    padding-bottom: 14px;
}

td[colspan] {
    border: 0;
}

td:nth-child(2) {
    width: 72px;
}

td b {
    font-size: var(--head);
}

td small {
    margin-top: 12px;
}

time {
    display: inline-block;
    text-align: right;
    float: right;
}

@media (max-width: 720px) {
    header nav {
        border-bottom-right-radius: 0;
        right: 0;
    }

    hr {
        margin-left: -12px;
        margin-right: -12px;
    }
}

@media (max-width: 414px) {
    td[rowspan] {
        width: 108px;
    }
}
""".data(using: .utf8)!
