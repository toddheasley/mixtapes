import SwiftUI
import Mixtapes

struct IconView: View {
    let size: CGSize
    let icon: Icon?
    
    init(_ icon: Icon? = nil, size: CGSize = CGSize(width: 152.0, height: 152.0)) {
        self.size = size
        self.icon = icon
    }
    
    private var nsImage: NSImage {
        guard let icon: Icon = icon,
              let nsImage: NSImage = NSImage(data: icon.data) else {
            return NSImage(data: Icon.data)!
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

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView()
    }
}
