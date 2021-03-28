import SwiftUI
import Mixtapes

struct SidebarView: View {
    @Binding var selection: Selection
    @EnvironmentObject private var mixtapes: Mixtapes
    
    // MARK: View
    var body: some View {
        List(mixtapes.index?.items ?? []) { item in
            ItemButton(item: item, selection: $selection)
            
        }
        .onDrop(of: [.fileURL], isTargeted: nil) { items in
            guard let item: NSItemProvider = items.first else {
                return false
            }
            item.fileURL { url, error in
                mixtapes.importItem(url)
            }
            return true
        }
    }
}

struct SidebarView_Previews: PreviewProvider {
    @State static private var selection: Selection = .auto
    
    // MARK: PreviewProvider
    static var previews: some View {
        SidebarView(selection: $selection)
            .environmentObject(Mixtapes())
    }
}
