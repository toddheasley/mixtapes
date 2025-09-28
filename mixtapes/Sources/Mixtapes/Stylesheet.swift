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
    -webkit-text-size-adjust: none;
    color-scheme: light dark;
}

a {
    text-decoration: none;
}

a img {
    display: inline-block;
    width: 96px;
}

audio, img {
    display: block;
}

audio, img, table {
    max-width: 448px;
    width: 100%;
}

body {
    font: bold 1em "\(Font.Name.gaegu)";
    letter-spacing: 0.05em;
    line-height: 1.33em;
    text-transform: uppercase;
}

h1 {
    font-size: 1.67em;
}

img {
    border-radius: 2.5px;
    box-shadow: 0 0 0.5px 0;
}

table {
    border-collapse: collapse;
}

td, th {
    border: 1px solid rgba(192, 192, 192, 0.33);
    text-align: left;
}

td:nth-child(2) {
    text-align: right;
}

th {
    color: rgb(192, 192, 192);
    font: 0.67em sans-serif;
}

.nowrap {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
""".data(using: .utf8)!
