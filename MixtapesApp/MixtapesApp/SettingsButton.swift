import SwiftUI
import Mixtapes

struct SettingsButton: View {
    @Binding var item: Item?
    
    private func toggleSettings() {
        item = nil
        
        print("toggleSettings")
    }
    
    // MARK: View
    var body: some View {
        Button(action: toggleSettings) {
            Image(systemName: "gearshape")
                .help("Podcast Settings")
        }
        .keyboardShortcut(",", modifiers: .command)
        .disabled(item == nil)
    }
}

struct SettingsButton_Previews: PreviewProvider {
    @State static private var item: Item? = nil
    
    // MARK: PreviewProvider
    static var previews: some View {
        SettingsButton(item: $item)
    }
}
