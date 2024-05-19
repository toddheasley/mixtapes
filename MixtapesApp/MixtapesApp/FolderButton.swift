import SwiftUI
import Mixtapes

struct FolderButton: View {
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    private let defaultMessage: String = "Choose Podcast Folder…"
    
    private var message: String {
        guard let url: URL = mixtapes.index?.url else { return defaultMessage }
        return "\((url.deletingLastPathComponent().path as NSString).abbreviatingWithTildeInPath)"
    }
    
    // MARK: View
    var body: some View {
        Button(action: {
            mixtapes.openFolder(defaultMessage, prompt: "Select")
        }) {
            HStack {
                Image(systemName: "folder")
                Text("\(message) ")
            }
        }
    }
}

#Preview {
    FolderButton()
        .environment(Mixtapes())
}
