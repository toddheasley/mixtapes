import Foundation

protocol Resource {
    var data: Data { get }
    var resources: [Self] { get }
    var url: URL { get }

}

extension Resource {
    var resources: [Self] { [] }
    
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
