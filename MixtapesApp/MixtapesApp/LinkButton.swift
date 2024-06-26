import SwiftUI
import Mixtapes

struct LinkButton: View {
    let url: URL?
    
    init(_ url: URL? = nil) {
        self.url = url
    }
    
    private var systemName: String {
        if ["https", "http"].contains(url?.scheme) {
            return "safari"
        } else if url?.scheme == "mailto" {
            return "envelope"
        } else if url?.isFileURL ?? false {
            return "folder"
        } else {
            return "link"
        }
    }
    
    private func openURL() {
        guard let url else { return }
        NSWorkspace.shared.open(url)
    }
    
    // MARK: View
    var body: some View {
        Button(action: openURL) {
            Image(systemName: systemName)
                .frame(width: 15.0)
        }
        .disabled(url == nil)
    }
}

#Preview {
    VStack {
        LinkButton(URL(string: "https://github.com/toddheasley"))
        LinkButton(URL(string: "mailto:toddheasley@me.com"))
        LinkButton(URL(string: "file:///Users/toddheasley"))
        LinkButton(nil)
    }
}
