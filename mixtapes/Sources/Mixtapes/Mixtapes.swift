import Foundation
import SwiftUI

public class Mixtapes: ObservableObject {
    @AppStorage("url") private static var url: URL?
    
    @Published public private(set) var index: Index? {
        didSet {
            do {
                error = nil
                try index?.write()
            } catch {
                self.error = Error(error)
            }
        }
    }
    
    @Published public var error: Error?
    
    public func importItem(_ url: URL?) {
        guard let url: URL = url, url.isFileURL,
              let destinationURL: URL = URL(string: url.lastPathComponent, relativeTo: index?.url) else {
            return
        }
        do {
            guard !(index?.items ?? []).map({ $0.id }).contains(url.deletingPathExtension().lastPathComponent) else {
                throw Error("Duplicate file name", url: url)
            }
            try FileManager.default.copyItem(at: url, to: destinationURL)
            index?.items.append(try Item(url: destinationURL))
        } catch {
            self.error = Error(error) ?? Error(error.localizedDescription)
        }
    }
    
    public func open(_ url: URL?) {
        do {
            index = url != nil ? (try Index(url: url)) : nil
            Self.url = index?.url
        } catch {
            self.error = Error(error)
        }
    }
    
    public init() {
        do {
            index = try Index(url: Self.url)
        } catch {
            Self.url = nil
        }
    }
}
