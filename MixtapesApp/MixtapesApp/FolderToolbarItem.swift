import SwiftUI
import Mixtapes

struct FolderToolbarItem: View {
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    
    // MARK: View
    var body: some View {
        Button(action: mixtapes.showInFinder) {
            Image(systemName: "folder")
                .help("Show in Finder")
        }
        .disabled(mixtapes.index == nil)
    }
}

#Preview {
    FolderToolbarItem()
        .environment(Mixtapes())
}
