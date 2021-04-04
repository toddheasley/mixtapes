import SwiftUI

extension Text {
    func secondaryStyle() -> some View {
        return truncationMode(.tail)
            .foregroundColor(Color.primary.opacity(0.5))
            .font(.system(size: 10.0, weight: .medium, design: .default))
            .textCase(.uppercase)
    }
    
    func primaryStyle() -> some View {
        return truncationMode(.tail)
            .foregroundColor(.accentColor)
            .textCase(.uppercase)
            .font(.gaegu())
    }
}
