import Foundation

struct Font: Resource {
    enum Name: String, CustomStringConvertible {
        case gaegu = "gaegu.woff"
        
        var format: String { rawValue.components(separatedBy: ".").last! }
        var path: String { rawValue }
        
        // MARK: CustomStringConvertible
        var description: String { rawValue.components(separatedBy: ".").first! }
    }
    
    init(_ name: Name, url: URL) throws {
        data = try Bundle.module.resource(name.path)
        self.url = URL(fileURLWithPath: "\(name.path)", relativeTo: url)
    }
    
    // MARK: Resource
    public let data: Data
    public let url: URL
}
