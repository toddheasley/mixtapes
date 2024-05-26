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
    --space: 7px;
    --thumb: 160px;
}

* {
    font-weight: normal;
    margin: 0;
}

a {
    text-decoration: none;
}

article, ul {
    align-items: flex-start;
    display: flex;
    flex-wrap: wrap;
}

article table {
    max-width: 384px;
    width: 100%;
}

article audio, article img {
    width: 100%;
}

article td:nth-child(2) {
    text-align: right;
}

body {
    font: 1em "\(Font.Name.gaegu)";
    text-transform: uppercase;
    padding: calc(var(--space) * 2) 0;
}

h1, p {
    padding: calc(var(--space) * 4) calc(var(--space) * 2);
}

h1 {
    font-size: 1.5em;
}

h1 img {
    display: inline-block;
    padding: 0 var(--space);
    vertical-align: bottom;
}

h4 {
    padding: var(--space) calc(var(--space) * 2);
    position: fixed;
    top: calc(var(--thumb) + (var(--space) * 4));
}

li {
    padding: var(--space);
}

table {
    border-collapse: collapse;
}

table a img, ul img {
    width: var(--thumb);
}

table img, ul img {
    border-radius: 1.5px;
    box-shadow: 0 0 2px 0 rgba(0, 0, 0, 0.2);
    display: block;
}

td, th {
    padding: var(--space) calc(var(--space) * 2) var(--space) 0;
    vertical-align: top;
}

td:first-child, th {
    padding-left: calc(var(--space) * 2);
}

th {
    font: 0.5em system-ui, sans-serif;
    text-align: left;
}

ul {
    list-style: none;
    padding: 0 var(--space);
}
""".data(using: .utf8)!
