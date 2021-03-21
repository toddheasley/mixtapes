import SwiftUI

extension Color {
    static func highlightColor(_ isHighlighted: Bool = true) -> Self {
        return Self("HighlightColor").opacity(isHighlighted ? 0.75 : 0.0)
    }
}
