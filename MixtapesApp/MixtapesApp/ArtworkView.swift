import SwiftUI
import Mixtapes

struct ArtworkView: View {
    let artwork: Artwork?
    
    init(item: Item? = nil) {
        artwork = item?.attachment.asset.artwork
    }
    
    init(_ artwork: Artwork?) {
        self.artwork = artwork
    }
    
    // MARK: View
    var body: some View {
        Image(nsImage: artwork?.nsImage ?? .clear)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 512.0)
            .cornerRadius(2.5)
    }
}

#Preview {
    ArtworkView()
}

private extension Artwork {
    var nsImage: NSImage? { NSImage(data: data) }
}

private extension NSImage {
    static var clear: Self { Self(data: Data(base64Encoded: NSImage_Base64Encoded_Clear)!)! }
}

private let NSImage_Base64Encoded_Clear: String = """
iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAAXNSR0IArs4c6QAAAAtJREFUCFtjYGAAAAADAAHc7H1IAAAAAElFTkSuQmCC
"""
