import Foundation

struct Font: Resource {
    public enum Name: String, CustomStringConvertible {
        case gaegu = "gaegu.woff" // https://fonts.google.com/specimen/Gaegu
        
        var format: String { rawValue.components(separatedBy: ".").last! }
        var path: String { rawValue }
        
        // MARK: CustomStringConvertible
        public var description: String { rawValue.components(separatedBy: ".").first! }
    }
    
    init(_ name: Name, url: URL) throws {
        self.url = URL(fileURLWithPath: "\(name.path)", relativeTo: url)
        data = try Bundle.module.resource(name.path)
    }
    
    // MARK: Resource
    let data: Data
    let url: URL
}
