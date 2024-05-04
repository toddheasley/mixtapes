import SwiftUI
import Mixtapes

struct PreviewToolbarItem: View {
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    
    private func preview() {
        guard let url: URL = mixtapes.index?.url.deletingPathExtension() else {
            return
        }
        NSWorkspace.shared.open(url.appendingPathExtension("html"))
    }
    
    // MARK: View
    var body: some View {
        Button(action: preview) {
            Image(systemName: "safari")
                .help("Preview")
        }
        .keyboardShortcut("O", modifiers: [.command, .option])
        .disabled(mixtapes.index == nil)
    }
}

#Preview {
    PreviewToolbarItem()
        .environment(Mixtapes())
}
