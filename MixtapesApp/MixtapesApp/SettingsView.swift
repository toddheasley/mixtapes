import SwiftUI
import Mixtapes

struct SettingsView: View {
    @EnvironmentObject private var mixtapes: Mixtapes
    
    // MARK: View
    var body: some View {
        VStack {
            IconView(mixtapes.index?.icon, size: CGSize(width: 270.0, height: 270.0))
            FolderButton()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        SettingsView()
            .environmentObject(Mixtapes())
    }
}
