import SwiftUI
import Mixtapes

struct FolderButton: View {
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    private let defaultMessage: String = "Choose Podcast Folder…"
    
    private var message: String {
        guard let url: URL = mixtapes.index?.url else { return defaultMessage }
        return "\((url.deletingLastPathComponent().path as NSString).abbreviatingWithTildeInPath)"
    }
    
    private func openURL() {
        let panel: NSOpenPanel = NSOpenPanel()
        panel.message = defaultMessage
        panel.prompt = "Select"
        panel.canCreateDirectories = true
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.begin { _ in
            guard let url: URL = panel.url else { return }
            mixtapes.open(url)
        }
    }
    
    // MARK: View
    var body: some View {
        Button(action: openURL) {
            HStack {
                Image(systemName: "folder")
                Text(message)
                    .frame(maxWidth: .defaultLength)
            }
        }
    }
}

#Preview {
    FolderButton()
        .environment(Mixtapes())
}
