import SwiftUI
import Mixtapes

struct SidebarView: View {
    @Binding var item: Item?
    @EnvironmentObject private var mixtapes: Mixtapes
    
    // MARK: View
    var body: some View {
        Image(systemName: "sidebar.left")
    }
}

struct SidebarView_Previews: PreviewProvider {
    @State static private var item: Item? = nil
    
    // MARK: PreviewProvider
    static var previews: some View {
        SidebarView(item: $item)
            .environmentObject(Mixtapes())
    }
}
