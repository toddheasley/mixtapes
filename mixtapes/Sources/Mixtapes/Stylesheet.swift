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
    --background: rgb(255, 255, 255);
    --color: rgb(0, 0, 0);
}

@media (prefers-color-scheme: dark) {
    :root {
        --background: rgb(0, 0, 0);
        --color: rgb(255, 255, 255);
    }
}

* {
    -webkit-text-size-adjust: 100%;
    font-weight: normal;
    margin: 0;
    padding: 0;
}

body {
    background: var(--background);
    color: var(--color);
    font: 19px "\(Font.Name.gaegu)";
}
""".data(using: .utf8)!

/*
private let Stylesheet_Data: Data = """
@font-face {
    font-family: "\(Font.Name.gaegu)";
    font-style: normal;
    font-weight: normal;
    src: url("\(Font.Name.gaegu.path)") format("\(Font.Name.gaegu.path.components(separatedBy: ".").last ?? "")");
}

:root {
    --background: #FEFEFE;
    --color: #1C41BF;
    --shadow: #DDDDDD;
    --meta: #B7B7B7;
    --opacity: 0.5;
}

@media (prefers-color-scheme: dark) {
    :root {
        --background: #222222;
        --color: #FEFEFE;
        --shadow: #444444;
        --meta: #444444;
        --opacity: 0.25;
    }
}

* {
    -webkit-text-size-adjust: 100%;
    font-weight: normal;
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
    font: 19px "gaegu";
    margin: 0 auto;
    max-width: 540px;
    text-transform: uppercase;
}

figure {
    overflow: hidden;
}

figure img {
    width: 100%;
}

footer {
    margin: 16px 0 32px 0;
}

h1 {
    font-size: 27px;
}

header {
    margin: 16px 0 12px 0;
}

hr {
    opacity: var(--opacity);
}

main {
    border-radius: 3px;
    box-shadow: 0 0 1px 1px var(--shadow);
    overflow: hidden;
}

table {
    margin: 11px 0;
    width: 100%;
}

td, th {
    max-width: 0;
    overflow: hidden;
    padding: 2px 11px;
    text-overflow: ellipsis;
    white-space: nowrap;
}

td:nth-child(2) {
    text-align: right;
    width: 90px;
}

td audio {
    margin: 4px 0 2px 0;
    position: relative;
    right: 1%;
    width: 102%;
}

td hr {
    border-top: 2px dotted var(--meta);
    display: block;
    height: 0px;
}

td img {
    float: right;
    margin-right: 3px;
}
    
th {
    color: var(--meta);
    font: bold 11px sans-serif;
    text-align: left;
}
""".data(using: .utf8)! */
