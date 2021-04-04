import SwiftUI
import Mixtapes

struct ImageView: View {
    let size: CGSize
    let item: Item?
    
    init(item: Item? = nil, size: CGSize = .square()) {
        self.size = size
        self.item = item
    }
    
    private var nsImage: NSImage {
        guard let url: URL = item?.image,
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
            .aspectRatio(CGSize(width: 1.0, height: 1.0), contentMode: .fit)
            .frame(width: size.width, height: size.height)
            .cornerRadius(.cornerRadius)
    }
}

struct ImageView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        ImageView(item: nil)
    }
}
