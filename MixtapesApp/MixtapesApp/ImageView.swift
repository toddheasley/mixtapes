import SwiftUI
import Mixtapes

struct ImageView: View {
    let size: CGSize
    let url: URL?
    
    init(_ url: URL? = nil, size: CGSize = CGSize(width: 420.0, height: 420.0)) {
        self.size = size
        self.url = url
    }
    
    private var nsImage: NSImage {
        guard let url: URL = url,
              let data: Data = try? Data(contentsOf: url),
              let nsImage: NSImage = NSImage(data: data) else {
            return .clear
        }
        return nsImage
    }
    
    // MARK: View
    var body: some View {
        Image(nsImage: nsImage)
            .resizable()
            .frame(width: size.width, height: size.height)
    }
}
