import SwiftUI
import Mixtapes

struct SettingsButton: View {
    @State private var isPresented: Bool = false
    @EnvironmentObject private var mixtapes: Mixtapes
    
    private func editSettings() {
        isPresented = true
    }
    
    // MARK: View
    var body: some View {
        Button(action: editSettings) {
            Text("Edit")
        }
        .sheet(isPresented: $isPresented) {
            SettingsEditor()
        }
        .disabled(mixtapes.index == nil)
    }
}

struct SettingsButton_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        SettingsButton()
            .environmentObject(Mixtapes())
    }
}
