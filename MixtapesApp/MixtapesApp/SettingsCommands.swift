import SwiftUI
import Mixtapes

struct SettingsCommands: View {
    @State var index: Index?
    
    private func toggleSettings() {
        NSApplication.shared.keyWindow?.toggleSettings()
    }
    
    // MARK: View
    var body: some View {
        Button(action: toggleSettings) {
            Text("Podcast Settings…")
        }
        .keyboardShortcut(",", modifiers: .command)
        .disabled(index == nil)
    }
}

struct SettingsCommands_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        SettingsCommands()
    }
}
