import SwiftUI
import Mixtapes

struct FileCommands: View {
    @EnvironmentObject private var mixtapes: Mixtapes
    
    private func importAudio() {
        NSApplication.shared.keyWindow?.importAudio()
    }
    
    private func showInFinder() {
        NSApplication.shared.keyWindow?.showInFinder()
    }
    
    private func preview() {
        NSApplication.shared.keyWindow?.preview()
    }
    
    // MARK: View
    var body: some View {
        Button(action: importAudio) {
            Text("Import Audio File…")
        }
        .keyboardShortcut("n", modifiers: [.command, .shift])
        .disabled(mixtapes.index == nil)
        Divider()
        Button(action: showInFinder) {
            Text("Show in Finder")
        }
        .disabled(mixtapes.index == nil)
        Button(action: preview) {
            Text("Preview")
        }
        .keyboardShortcut("o", modifiers: [.command, .shift])
        .disabled(mixtapes.index == nil)
    }
}

struct FileCommands_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        FileCommands()
            .environmentObject(Mixtapes())
    }
}
