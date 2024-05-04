import SwiftUI
import Mixtapes

struct SettingsToolbarItem: View {
    init(selection: Binding<Selection>) {
        _selection = selection
    }
    
    @Binding private var selection: Selection
    
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

#Preview {
    SettingsToolbarItem(selection: .constant(.auto))
}
