import SwiftUI
import Mixtapes

struct SettingsButton: View {
    @Binding var selection: Selection
    
    private func toggleSettings() {
        print("toggleSettings")
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

struct SettingsButton_Previews: PreviewProvider {
    @State static private var selection: Selection = .auto
    
    // MARK: PreviewProvider
    static var previews: some View {
        SettingsButton(selection: $selection)
    }
}
