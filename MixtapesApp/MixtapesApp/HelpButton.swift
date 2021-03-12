import SwiftUI

struct HelpButton: View {
    
    // MARK: View
    var body: some View {
        Button("Mixtapes Documentation and Source Code") {
            NSWorkspace.shared.open(URL(string: "https://github.com/toddheasley/mixtapes")!)
        }
    }
}

struct HelpButton_Previews: PreviewProvider {
    static var previews: some View {
        HelpButton()
    }
}
