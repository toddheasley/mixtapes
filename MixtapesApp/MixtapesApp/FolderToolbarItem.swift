import SwiftUI
import Mixtapes

struct FolderToolbarItem: View {
    @EnvironmentObject private var mixtapes: Mixtapes
    
    private func showInFinder() {
        guard let url: URL = mixtapes.index?.url.deletingLastPathComponent() else {
            return
        }
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

struct FolderToolbarItem_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        FolderToolbarItem()
            .environmentObject(Mixtapes())
    }
}
