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
            .font(.system(size: 9.0, weight: .medium, design: .default))
            .textCase(.uppercase)
            .opacity(0.83)
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
