import SwiftUI
import Mixtapes

@MainActor
enum Selection: Sendable, Equatable, @preconcurrency CustomStringConvertible {
    case item(Item), settings
    
    static let auto: Self = .settings
    
    var item: Item? {
        switch self {
        case .item(let item):
            return item
        default:
            return nil
        }
    }
    
    // MARK: CustomStringConvertible
    var description: String {
        switch self {
        case .item(let item):
            return "\(App.title) - \(item.title)"
        case .settings:
            return "\(App.title) - Settings"
        }
    }
}
