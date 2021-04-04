import Foundation

struct Font: Resource {
    enum Name: String, CustomStringConvertible {
        case gaegu = "gaegu.woff"
        
        var format: String {
            return rawValue.components(separatedBy: ".").last!
        }
        
        var path: String {
            return rawValue
        }
        
        // MARK: CustomStringConvertible
        var description: String {
            return rawValue.components(separatedBy: ".").first!
        }
    }
    
    init(_ name: Name, url: URL) throws {
        self.url = URL(fileURLWithPath: "\(name.path)", relativeTo: url)
        data = try Bundle.module.resource(name.path)
    }
    
    // MARK: Resource
    public let url: URL
    public let data: Data
}
