import SwiftUI
import Mixtapes

struct ItemButton: View {
    @EnvironmentObject private var mixtapes: Mixtapes
    
    private func openItem() {
        
    }
    
    // MARK: View
    var body: some View {
        Button(action: openItem) {
            Image(systemName: "plus.rectangle")
                .help("Import Mixtape")
        }
        .keyboardShortcut("N", modifiers: [.command, .option])
        .disabled(mixtapes.index == nil)
    }
}

struct ItemButton_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        ItemButton()
            .environmentObject(Mixtapes())
    }
}
