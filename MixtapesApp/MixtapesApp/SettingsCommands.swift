import SwiftUI
import Mixtapes

struct SettingsCommands: View {
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    
    // MARK: View
    var body: some View {
        Button(action: Mixtapes.toggleSettings) {
            Text("Podcast Settings…")
        }
        .keyboardShortcut(",", modifiers: .command)
        .disabled(mixtapes.index == nil)
        Button(action: mixtapes.forget) {
            Text("Forget Current Podcast")
        }
        .disabled(mixtapes.index == nil)
    }
}

#Preview {
    SettingsCommands()
        .environment(Mixtapes())
}
