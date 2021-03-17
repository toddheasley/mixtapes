import SwiftUI
import Mixtapes

struct PreviewButton: View {
    @EnvironmentObject private var mixtapes: Mixtapes
    
    private func preview() {
        guard let url: URL = mixtapes.index?.url.deletingPathExtension().appendingPathExtension("html") else {
            return
        }
        NSWorkspace.shared.open(url)
    }
    
    // MARK: View
    var body: some View {
        Button(action: preview) {
            Image(systemName: "safari")
                .help("Preview")
        }
        .disabled(mixtapes.index == nil)
    }
}

struct PreviewButton_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        PreviewButton()
            .environmentObject(Mixtapes())
    }
}
