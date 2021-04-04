import Foundation

protocol Resource {
    var url: URL { get }
    var data: Data { get }
    var resources: [Resource] { get }
}

extension Resource {
    var resources: [Resource] {
        return []
    }
    
    func write() throws {
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
}
