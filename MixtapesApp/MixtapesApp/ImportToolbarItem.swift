import SwiftUI
import UniformTypeIdentifiers
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
            item.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { data, _ in
                guard let data: Data = data as? Data,
                      let url: URL = URL(dataRepresentation: data, relativeTo: nil, isAbsolute: true) else {
                    return
                }
                Task { @MainActor in
                    mixtapes.importItem(url)
                }
            }
            return true
        }
    }
}

#Preview {
    ImportToolbarItem()
        .environment(Mixtapes())
}
