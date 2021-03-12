import Foundation

public class Mixtapes: ObservableObject {
    @Published public private(set) var index: Index?
    
    public func open(_ url: URL) throws {
        index = try Index(url: url)
        UserDefaults.standard.url = index?.url
    }
    
    public init() {
        do {
            index = try Index(url: UserDefaults.standard.url)
        } catch {
            UserDefaults.standard.url = nil
        }
    }
}

extension Mixtapes {
    public static var current: Self? {
        return nil
    }
}
