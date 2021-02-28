import Foundation

struct Stylesheet: Resource {
    init(url: URL) throws {
        self.url = URL(fileURLWithPath: "default.css", relativeTo: url)
        data = Stylesheet_Data
        resources = [
            try Font(.gaegu, url: url)
        ]
    }
    
    // MARK: Resource
    public let url: URL
    public let data: Data
    public let resources: [Resource]
}

private let Stylesheet_Data: Data = """
@font-face {
    font-family: "\(Font.Name.gaegu)";
    font-style: normal;
    font-weight: normal;
    src: url("\(Font.Name.gaegu.path)") format("\(Font.Name.gaegu.format)");
}

:root {
    --background-color: rgb(255, 255, 247);
    --bleed-color: gainsboro;
    --box-shadow: 0 0 1px 1px rgba(102, 102, 102, 0.2);
    --color: rgb(51, 51, 51);
}

@media (prefers-color-scheme: dark) {
    :root {
        --bleed-color: var(--color);
    }
}

* {
    margin: 0;
    padding: 0;
}

a {
    background: pink;
    color: inherit;
    text-decoration: none;
}

article {
    background: var(--background-color);
    overflow: hidden;
}

article table {
    margin: 13px 0;
    width: 100%;
}

article td {
    max-width: 0;
}

article td:nth-child(2) {
    text-align: right;
    padding-left: 0;
    width: 25%;
}

audio, img {
    display: block;
}

audio, figure img {
    width: 100%;
}

body {
    background: var(--background-color);
    color: mediumblue;
    font: 19px "\(Font.Name.gaegu)";
    margin: 0 auto;
    max-width: 540px;
    position: relative;
    text-transform: uppercase;
}

figure {
    overflow: hidden;
}

hr {
    opacity: 0.5;
}

nav {
    background: rgb(255, 255, 243);
    border-radius: 9px;
    box-shadow: var(--box-shadow);
    left: 6px;
    overflow: hidden;
    position: absolute;
    transform: rotate(-0.5deg);
    top: 6px;
}

nav table {
    border-collapse: collapse;
    
}

nav td {
    padding: 6px;
}

nav td:first-child {
    background: var(--color);
}

nav td:nth-child(2) {
    min-width: 210px;
    text-align: center;
}

td, th {
    overflow: hidden;
    padding: 2px 11px;
    text-overflow: ellipsis;
    white-space: nowrap;
}

td hr {
    border-top: 2px dotted var(--color);
    display: block;
    height: 0;
}

th {
    color: var(--color);
    font: bold 12px sans-serif;
    text-align: left;
}

@media (min-width: 540px) {
    article {
        border-radius: 5px;
        box-shadow: var(--box-shadow);
    }
    
    body {
        background: var(--bleed-color);
        margin: 19px auto;
    }
}
""".data(using: .utf8)!
