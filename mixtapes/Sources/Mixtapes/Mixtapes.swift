import SwiftUI

@MainActor
@Observable public class Mixtapes {
    public var index: Index? {
        didSet {
            do {
                error = nil
                try index?.write()
            } catch {
                self.error = Error(error)
            }
        }
    }
    
    public var error: Error? {
        didSet {
            guard let error else { return }
            DispatchQueue.main.asyncAfter(deadline: .secondsFromNow(5.0)) {
                guard self.error == error else { return }
                self.error = nil
            }
        }
    }
    
    public func importItem(_ url: URL?) {
        guard let url, url.isFileURL,
              let destinationURL: URL = URL(string: url.lastPathComponent, relativeTo: index?.url) else {
            return
        }
        Task {
            do {
                guard !(index?.items ?? []).map({ $0.id }).contains(url.deletingPathExtension().lastPathComponent) else {
                    throw Error("Duplicate file name", url: url)
                }
                try FileManager.default.copyItem(at: url, to: destinationURL)
                let item: Item = try await Item(url: destinationURL)
                index?.items.append(item)
            } catch {
                self.error = Error(error) ?? Error(error.localizedDescription)
            }
        }
    }
    
    public func importIcon(_ url: URL?) {
        guard let url, url.isFileURL else { return }
        do {
            let data: Data = try Data(contentsOf: url)
            try index?.icon.reset(data)
        } catch {
            self.error = Error(error) ?? Error(error.localizedDescription)
        }
    }
    
    public func open(_ url: URL?) {
        Task {
            do {
                index = url != nil ? (try await Index(url: url)) : nil
                Self.url = index?.url
            } catch {
                self.error = Error(error) ?? Error(error.localizedDescription)
            }
        }
    }
    
    public init() {
        open(Self.url)
    }
    
    @AppStorage("url") private static var url: URL?
}

private extension DispatchTime {
    static func secondsFromNow(_ seconds: TimeInterval) -> Self {
        .now() + max(seconds, 0.0)
    }
}
