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
    public let data: Data
    public let resources: [Resource]
    public let url: URL
}

private let Stylesheet_Data: Data = """
@font-face {
    font-family: "\(Font.Name.gaegu)";
    font-style: normal;
    font-weight: normal;
    src: url("\(Font.Name.gaegu.path)") format("\(Font.Name.gaegu.format)");
}

body {
    font: 1em "\(Font.Name.gaegu)";
    text-transform: uppercase;
}
""".data(using: .utf8)!
