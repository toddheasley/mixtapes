import SwiftUI
import Mixtapes

struct URLButton: View {
    @EnvironmentObject private var mixtapes: Mixtapes
    
    private let defaultMessage: String = "Choose Podcast Folder…"
    
    private var message: String {
        guard let url: URL = mixtapes.index?.url else {
            return defaultMessage
        }
        return "\(url)"
    }
    
    private func openURL() {
        let panel: NSOpenPanel = NSOpenPanel()
        panel.message = defaultMessage
        panel.prompt = "Select"
        panel.canCreateDirectories = true
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.begin { _ in
            guard let url: URL = panel.url else {
                return
            }
            mixtapes.open(url)
        }
    }
    
    // MARK: View
    var body: some View {
        Button(action: openURL) {
            HStack {
                Image(systemName: "folder")
                Text(message)
                    .padding(.trailing, 3.0)
            }
        }
        .buttonStyle(BorderedButtonStyle())
    }
}

struct URLButton_Previews: PreviewProvider {
    @State static private var item: Item? = nil
    
    // MARK: PreviewProvider
    static var previews: some View {
        URLButton()
            .environmentObject(Mixtapes())
    }
}

