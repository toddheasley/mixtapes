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
    font-style: normal;
    font-weight: normal;
    src: url("\(Font.Name.gaegu.path)") format("\(Font.Name.gaegu.format)");
}

:root {
    color-scheme: light dark;
    -webkit-text-size-adjust: none;
    --thumb: 96px;
}

* {
    font-weight: normal;
    margin: 0;
}

a {
    text-decoration: none;
}

a img {
    width: var(--thumb);
}

audio, iframe, img {
    display: block;
    width: 100%;
}

body {
    font: 1em "\(Font.Name.gaegu)";
    text-transform: uppercase;
}

caption, td, th {
    text-align: left;
}

caption {
    position: fixed;
}

hr {
    opacity: 0.5;
}

iframe, img {
    border-radius: 1.5px;
    border: none;
}

iframe {
    background: rgba(192, 192, 192, 0.1);
    box-shadow: inset 0 0 1px 0;
    height: calc(var(--thumb) + 33px + 1em);
}

img {
    box-shadow: 0 0 1px 0;
}

span {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

table {
    border-spacing: 9px;
    caption-side: bottom;
    max-width: calc(var(--thumb) * 5);
}

td:nth-child(2) {
    text-align: right;
}

th {
    font: 0.67em ui-sans-serif, sans-serif;
    opacity: 0.9;
}

.nowrap {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    max-width: calc(var(--thumb) * 2.5);
}
""".data(using: .utf8)!
