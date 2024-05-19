import SwiftUI

extension Text {
    func primary() -> some View {
        truncationMode(.tail)
            .foregroundColor(.accentColor)
            .textCase(.uppercase)
            .font(.gaegu)
    }
    
    func secondary() -> some View {
        truncationMode(.tail)
            .foregroundColor(Color.primary.opacity(0.5))
            .font(.system(size: 10.0, weight: .medium, design: .default))
            .textCase(.uppercase)
    }
}

#Preview {
    VStack {
        Text("Primary")
            .primary()
        Text("Secondary")
            .secondary()
    }
}
