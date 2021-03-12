import SwiftUI

extension Text {
    func bodyStyle() -> some View {
        return self
            .truncationMode(.tail)
            .foregroundColor(.foreground)
            .textCase(.uppercase)
            .font(.gaegu())
    }
}
