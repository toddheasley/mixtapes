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
