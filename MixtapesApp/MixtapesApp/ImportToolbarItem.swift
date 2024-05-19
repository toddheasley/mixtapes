import SwiftUI
import Mixtapes

struct ImportToolbarItem: View {
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    
    // MARK: View
    var body: some View {
        Button(action: {
            mixtapes.importAudio("Choose Audio File…", prompt: "Import")
        }) {
            Image(systemName: "plus.rectangle")
                .help("Import Audio File…")
        }
        .disabled(mixtapes.index == nil)
        .onDrop(of: [.fileURL], isTargeted: nil) { items in
            guard let item: NSItemProvider = items.first else { return false }
            item.fileURL { url, error in
                mixtapes.importItem(url)
            }
            return true
        }
    }
}

#Preview {
    ImportToolbarItem()
        .environment(Mixtapes())
}
