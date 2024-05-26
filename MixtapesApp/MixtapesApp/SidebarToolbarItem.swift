import SwiftUI
import Mixtapes

struct SidebarToolbarItem: View {
    
    // MARK: View
    var body: some View {
        Button(action: Mixtapes.toggleSidebar) {
            Image(systemName: "sidebar.left")
                .help("Toggle Sidebar")
        }
    }
}

#Preview {
    SidebarToolbarItem()
}
