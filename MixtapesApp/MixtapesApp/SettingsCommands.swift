import SwiftUI
import Mixtapes

struct SettingsCommands: View {
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    
    private func toggleSettings() {
        NSApplication.shared.keyWindow?.toggleSettings()
    }
    
    private func forgetSettings() {
        mixtapes.open(nil)
    }
    
    // MARK: View
    var body: some View {
        Button(action: toggleSettings) {
            Text("Podcast Settings…")
        }
        .keyboardShortcut(",", modifiers: .command)
        .disabled(mixtapes.index == nil)
        Button(action: forgetSettings) {
            Text("Forget Current Podcast")
        }
        .disabled(mixtapes.index == nil)
    }
}

#Preview {
    SettingsCommands()
        .environment(Mixtapes())
}
