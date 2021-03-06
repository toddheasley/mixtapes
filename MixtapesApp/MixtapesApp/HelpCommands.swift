import SwiftUI

struct HelpCommands: View {
    private func viewSource() {
        NSWorkspace.shared.open(URL(string: "https://github.com/toddheasley/mixtapes")!)
    }
    
    // MARK: View
    var body: some View {
        Button(action: viewSource) {
            Text("Mixtapes Documentation and Source Code")
        }
    }
}

struct HelpCommands_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        HelpCommands()
    }
}
