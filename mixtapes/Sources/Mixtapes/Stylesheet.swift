import Foundation

struct Stylesheet: Resource {
    init(url: URL) throws {
        self.url = URL(fileURLWithPath: "html.css", relativeTo: url)
        data = Stylesheet_Data
        resources = [
            try Font(.gaegu, url: url)
        ]
    }
    
    // MARK: Resource
    let data: Data
    let resources: [Resource]
    let url: URL
}

private let Stylesheet_Data: Data = """
@font-face {
    font-family: "\(Font.Name.gaegu)";
    src: url("\(Font.Name.gaegu.path)") format("\(Font.Name.gaegu.format)");
}

:root {
    color-scheme: light dark;
    -webkit-text-size-adjust: none;
    --thumb: 96px;
}

* {
    margin: 0;
}

a {
    text-decoration: none;
}

a img {
    width: var(--thumb);
}

audio, caption {
    margin: 0.67em 0;
}

audio, iframe, img {
    display: block;
    width: 100%;
}

body {
    font: 1em "\(Font.Name.gaegu)";
    letter-spacing: 0.05em;
    line-height: 1.33em;
    margin: 0 auto;
    max-width: calc(var(--thumb) * 4);
    text-transform: uppercase;
}

caption, td, th {
    text-align: left;
}

caption {
    position: fixed;
}

hr {
    margin-top: 0.33em;
}

hr, th {
    opacity: 0.67;
}

iframe, img {
    background: rgba(192, 192, 192, 0.33);
    border-radius: 2.5px;
}

iframe {
    border: 0;
    box-shadow: inset 0 0 0.5px 0;
    height: calc(var(--thumb) * 2 + 2em);
    margin-top: 1em;
}

img:not([src="icon.png"]) {
    box-shadow: 0 0 0.5px 0;
}

table {
    border-spacing: 0.33em;
    caption-side: bottom;
    margin: 0.67em;
}

td:nth-child(2) {
    text-align: right;
}

th {
    font: 0.67em sans-serif;
    padding-bottom: 0.67em;
}

.nowrap {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    max-width: calc(var(--thumb) * 2);
}
""".data(using: .utf8)!
