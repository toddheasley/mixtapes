import SwiftUI
import Mixtapes

struct SettingsEditor: View {
    @EnvironmentObject private var mixtapes: Mixtapes
    
    // MARK: View
    var body: some View {
        VStack {
            Text("Settings Editor")
        }
        .padding()
        .background(Color.white)
    }
}

struct SettingsEditor_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        SettingsEditor()
    }
}

