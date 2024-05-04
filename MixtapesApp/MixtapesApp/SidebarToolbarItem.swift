import SwiftUI

struct SidebarToolbarItem: View {
    private func toggleSidebar() {
        NSApplication.shared.keyWindow?.toggleSidebar()
    }
    
    // MARK: View
    var body: some View {
        Button(action: toggleSidebar) {
            Image(systemName: "sidebar.left")
                .help("Toggle Sidebar")
        }
    }
}

#Preview {
    SidebarToolbarItem()
}
