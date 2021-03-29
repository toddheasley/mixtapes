import SwiftUI
import Mixtapes

struct SettingsView: View {
    @EnvironmentObject private var mixtapes: Mixtapes
    
    // MARK: View
    var body: some View {
        VStack {
            IconButton()
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
