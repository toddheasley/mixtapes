import Foundation

var resources: URL { Bundle.module.resourceURL! }

func resource(_ path: String) -> URL {
    URL(fileURLWithPath: path, relativeTo: resources)
}
