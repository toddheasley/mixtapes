import SwiftUI
import Mixtapes

struct IconButton: View {
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    @State private var isTargeted: Bool = false
    @State private var isHovering: Bool = false
    
    // MARK: View
    var body: some View {
        Button(action: {
            mixtapes.importIcon("Choose Icon File…", prompt: "Import")
        }) {
            ZStack {
                Image(nsImage: mixtapes.index?.icon.nsImage ?? Icon.nsImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 256.0)
                    .opacity(isHovering ? 0.1 : 1.0)
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32.0)
                    .foregroundColor(.secondary)
                    .opacity(isHovering ? 0.5 : 0.0)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .onHover { isHovering in
            self.isHovering = isHovering
        }
        .onDrop(of: [.fileURL], isTargeted: $isTargeted) { items in
            guard let item: NSItemProvider = items.first else { return false }
            item.fileURL { url, error in
                mixtapes.importIcon(url)
            }
            return true
        }
        .disabled(mixtapes.index == nil)
    }
}

#Preview {
    IconButton()
        .environment(Mixtapes())
}

private extension Icon {
    static var nsImage: NSImage { NSImage(data: Self.data)! }
    var nsImage: NSImage? { NSImage(data: data) }
}
