import Foundation
import SwiftUI

public class Mixtapes: ObservableObject {
    @AppStorage("url") private static var url: URL?
    
    @Published public private(set) var index: Index? {
        didSet {
            do {
                try index?.write()
            } catch {
                self.error = Error(error)
            }
        }
    }
    
    @Published public private(set) var error: Error? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                self?.error = nil
            }
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
