import SwiftUI
import Mixtapes

struct SettingsToolbarItem: View {
    @Binding var selection: Selection
    
    private func toggleSettings() {
        selection = .settings
    }
    
    // MARK: View
    var body: some View {
        Button(action: toggleSettings) {
            Image(systemName: "gearshape")
                .help("Podcast Settings")
        }
        .keyboardShortcut(",", modifiers: [.command, .option])
        .disabled(selection == .settings)
    }
}

struct SettingsToolbarItem_Previews: PreviewProvider {
    @State static private var selection: Selection = .auto
    
    // MARK: PreviewProvider
    static var previews: some View {
        SettingsToolbarItem(selection: $selection)
    }
}
