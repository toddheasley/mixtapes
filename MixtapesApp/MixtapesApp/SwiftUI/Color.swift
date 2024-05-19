import SwiftUI

extension Color {
    static func highlightColor(_ isHighlighted: Bool = true) -> Self {
        Self("HighlightColor").opacity(isHighlighted ? 0.9 : 0.0)
    }
}

#Preview {
    VStack {
        Rectangle()
            .fill(Color.highlightColor(false))
        Rectangle()
            .fill(Color.highlightColor())
    }
}
