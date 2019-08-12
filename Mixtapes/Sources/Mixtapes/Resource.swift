import Foundation

public class Resource {
    public enum Error: Swift.Error {
        case resourceNotFound
    }
    
    public let url: URL
    public let data: Data
    public let resources: [Resource]
    
    public var isEmpty: Bool {
        return data.isEmpty
    }
    
    public func write() throws {
        for resource in resources {
            try resource.write()
        }
        try data.write(to: url)
    }
    
    public init(url: URL, data: Data = Data(), resources: [Resource] = []) {
        self.url = url
        self.data = data
        self.resources = resources
    }
}
