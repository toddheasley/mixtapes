import SwiftUI
import Mixtapes

struct FileCommands: View {
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    
    // MARK: View
    var body: some View {
        Button(action: {
            mixtapes.importAudio("Choose Audio File…", prompt: "Import")
        }) {
            Text("Import Audio File…")
        }
        .keyboardShortcut("N", modifiers: [.command, .option])
        .disabled(mixtapes.index == nil)
        Divider()
        Button(action: mixtapes.showInFinder) {
            Text("Show in Finder")
        }
        .keyboardShortcut("O")
        .disabled(mixtapes.index == nil)
        Button(action: mixtapes.preview) {
            Text("Preview")
        }
        .keyboardShortcut("O", modifiers: [.command, .option])
        .disabled(mixtapes.index == nil)
    }
}

#Preview {
    FileCommands()
        .environment(Mixtapes())
}
