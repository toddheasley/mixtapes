import Foundation

public class JSON: Resource {
    public init(index: Index) {
        let data: Data =  try! JSONEncoder(url: index.homepage, formatting: [.prettyPrinted, .sortedKeys]).encode(index)
        var string: String = String(data: data, encoding: .utf8)!
        string = string.replacingOccurrences(of: "  ", with: "    ")
        string = string.replacingOccurrences(of: " : ", with: ": ")
        super.init(url: URL(fileURLWithPath: "index.json", relativeTo: index.url), data: string.data(using: .utf8)!)
    }
}
