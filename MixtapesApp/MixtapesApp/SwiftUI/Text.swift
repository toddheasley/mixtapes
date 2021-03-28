import SwiftUI

extension Text {
    func secondaryStyle() -> some View {
        return truncationMode(.tail)
            .foregroundColor(Color.primary.opacity(0.9))
            .font(.system(size: 11.0, weight: .medium, design: .default))
    }
    
    func primaryStyle() -> some View {
        return truncationMode(.tail)
            .foregroundColor(.accentColor)
            .textCase(.uppercase)
            .font(.gaegu())
    }
}
