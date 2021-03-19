import SwiftUI
import Mixtapes

struct SettingsView: View {
    
    // MARK: View
    var body: some View {
        URLButton()
    }
}

struct SettingsView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        SettingsView()
            .environmentObject(Mixtapes())
    }
}
