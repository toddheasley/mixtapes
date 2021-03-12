import SwiftUI

struct SidebarView: View {
    
    // MARK: View
    var body: some View {
        List(0..<25) { index in
            Text("SIDEBAR")
        }
    }
}
