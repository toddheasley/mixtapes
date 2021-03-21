import SwiftUI

extension Text {
    func secondaryStyle() -> some View {
        return self
            .truncationMode(.tail)
            .foregroundColor(Color.primary.opacity(0.9))
            .textCase(.uppercase)
            .font(.system(size: 11.0, weight: .medium, design: .default))
    }
    
    func primaryStyle() -> some View {
        return self
            .truncationMode(.tail)
            .foregroundColor(.accentColor)
            .textCase(.uppercase)
            .font(.gaegu())
    }
}
