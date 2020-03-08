import Foundation

public class Resource {
    public let url: URL
    public let data: Data
    public let resources: [Resource]
    
    public var isEmpty: Bool {
        return data.isEmpty
    }
    
    public func write() throws {
        do {
            for resource in resources {
                try resource.write()
            }
            try data.write(to: url)
        } catch is EncodingError {
            throw Error("Resource encoding failed", url: url)
        } catch {
            throw error as? Error ?? Error("Resource write failed", url: url)
        }
    }
    
    public init(url: URL, data: Data = Data(), resources: [Resource] = []) {
        self.url = url
        self.data = data
        self.resources = resources
    }
}
