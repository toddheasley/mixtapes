import SwiftUI
import Mixtapes

struct HelpCommands: View {
    
    // MARK: View
    var body: some View {
        Button(action: Mixtapes.viewSource) {
            Text("Mixtapes Documentation and Source Code")
        }
    }
}

#Preview {
    HelpCommands()
}
