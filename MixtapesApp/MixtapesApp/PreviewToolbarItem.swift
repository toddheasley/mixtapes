import SwiftUI
import Mixtapes

struct PreviewToolbarItem: View {
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    
    // MARK: View
    var body: some View {
        Button(action: mixtapes.preview) {
            Image(systemName: "safari")
                .help("Preview")
        }
        .disabled(mixtapes.index == nil)
    }
}

#Preview {
    PreviewToolbarItem()
        .environment(Mixtapes())
}
