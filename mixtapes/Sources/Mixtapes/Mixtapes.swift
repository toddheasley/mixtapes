import Foundation

public class Mixtapes: ObservableObject {
    @Published public private(set) var index: Index?
    
    public func open(_ url: URL?) throws {
        index = try Index(url: url)
        UserDefaults.standard.url = index?.url
    }
    
    public func reset() {
        UserDefaults.standard.url  = nil
        index = nil
    }
    
    public init() {
        do {
            index = try Index(url: UserDefaults.standard.url)
        } catch {
            UserDefaults.standard.url = nil
        }
    }
}
