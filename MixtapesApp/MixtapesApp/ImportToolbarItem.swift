import SwiftUI
import AVFoundation
import Mixtapes

struct ImportToolbarItem: View {
    @EnvironmentObject private var mixtapes: Mixtapes
    
    private func importItem() {
        let panel: NSOpenPanel = NSOpenPanel()
        panel.message = "Choose Audio File…"
        panel.prompt = "Import"
        panel.allowedContentTypes = Asset.contentTypes
        panel.canChooseFiles = true
        panel.begin { _ in
            mixtapes.importItem(panel.url)
        }
    }
    
    // MARK: View
    var body: some View {
        Button(action: importItem) {
            Image(systemName: "plus.rectangle")
                .help("Import Audio File")
        }
        .keyboardShortcut("N", modifiers: [.command, .option])
        .disabled(mixtapes.index == nil)
        .onDrop(of: [.fileURL], isTargeted: nil) { items in
            guard let item: NSItemProvider = items.first else {
                return false
            }
            item.fileURL { url, error in
                mixtapes.importItem(url)
            }
            return true
        }
    }
}

struct ImportToolbarItem_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        ImportToolbarItem()
            .environmentObject(Mixtapes())
    }
}
