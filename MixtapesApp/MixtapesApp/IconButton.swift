import SwiftUI
import UniformTypeIdentifiers
import Mixtapes

struct IconButton: View {
    let size: CGSize
    
    init(size: CGSize = .square()) {
        self.size = size
    }
    
    @State private var isTargeted: Bool = false
    @State private var isHovering: Bool = false
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
        panel.allowedContentTypes = Icon.contentTypes
        panel.canChooseFiles = true
        panel.begin { _ in
            mixtapes.importIcon(panel.url)
        }
    }
    
    // MARK: View
    var body: some View {
        Button(action: importIcon) {
            ZStack {
                Image(nsImage: nsImage)
                    .resizable()
                    .aspectRatio(CGSize(width: 1.0, height: 1.0), contentMode: .fit)
                    .frame(width: size.width, height: size.height)
                    .cornerRadius(.cornerRadius)
                if isTargeted {
                    Text("TARGETED")
                } else if isHovering {
                    Text("HOVERING")
                }
            }
            .opacity(isHovering ? 0.5 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .onDrop(of: [.fileURL], isTargeted: $isTargeted) { items in
            guard let item: NSItemProvider = items.first else {
                return false
            }
            item.fileURL { url, error in
                mixtapes.importIcon(url)
            }
            return true
        }
        .onHover { isHovering in
            self.isHovering = isHovering
        }
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
