import SwiftUI
import Mixtapes

struct FolderToolbarItem: View {
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    
    private func showInFinder() {
        guard let url: URL = mixtapes.index?.url.deletingLastPathComponent() else { return }
        NSWorkspace.shared.open(url)
    }
    
    // MARK: View
    var body: some View {
        Button(action: showInFinder) {
            Image(systemName: "folder")
                .help("Show in Finder")
        }
        .keyboardShortcut("o", modifiers: [.command])
        .disabled(mixtapes.index == nil)
    }
}

#Preview {
    FolderToolbarItem()
        .environment(Mixtapes())
}
