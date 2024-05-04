import SwiftUI
import Mixtapes

struct SidebarView: View {
    init(selection: Binding<Selection>) {
        _selection = selection
    }
    
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    @Binding private var selection: Selection
    
    // MARK: View
    var body: some View {
        if let index: Index = mixtapes.index {
            List(index.items) { item in
                ItemButton(item, selection: $selection)
                
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
}

#Preview {
    SidebarView(selection: .constant(.auto))
        .environment(Mixtapes())
}
