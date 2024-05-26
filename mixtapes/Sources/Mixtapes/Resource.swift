import Foundation

public protocol Resource {
    var data: Data { get }
    var resources: [Resource] { get }
    var url: URL { get }
}

extension Resource {
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
    
    // MARK: Resource
    public var resources: [Resource] { [] }
}
