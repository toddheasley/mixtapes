import SwiftUI
import Mixtapes

struct IconButton: View {
    let size: CGSize
    
    init(size: CGSize = .square()) {
        self.size = size
    }
    
    @EnvironmentObject private var mixtapes: Mixtapes
    
    private var nsImage: NSImage {
        guard let icon: Icon = mixtapes.index?.icon,
              let nsImage: NSImage = NSImage(data: icon.data) else {
            return NSImage(data: Icon.data)!
        }
        return nsImage
    }
    
    private func importIcon() {
        let panel: NSOpenPanel = NSOpenPanel()
        panel.message = "Choose Icon File…"
        panel.prompt = "Import"
        panel.allowedContentTypes = [.png, .jpeg]
        panel.canChooseFiles = true
        panel.begin { _ in
            mixtapes.importIcon(panel.url)
        }
    }
    
    // MARK: View
    var body: some View {
        Button(action: importIcon) {
            Image(nsImage: nsImage)
                .resizable()
                .aspectRatio(CGSize(width: 1.0, height: 1.0), contentMode: .fit)
                .frame(width: size.width, height: size.height)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(mixtapes.index == nil)
    }
}

struct IconButton_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        IconButton()
            .environmentObject(Mixtapes())
    }
}
