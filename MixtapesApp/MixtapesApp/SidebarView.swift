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
        ScrollView {
            LazyVStack {
                ForEach(mixtapes.index?.items ?? []) { item in
                    ItemButton(item, selection: $selection)
                }
            }
            .padding()
        }
        .onDrop(of: [.fileURL], isTargeted: nil) { items in
            guard !items.isEmpty else { return false }
            for item in items {
                item.fileURL { url, error in
                    mixtapes.importItem(url)
                }
            }
            return true
        }
    }
}

#Preview {
    SidebarView(selection: .constant(.auto))
        .environment(Mixtapes())
}
