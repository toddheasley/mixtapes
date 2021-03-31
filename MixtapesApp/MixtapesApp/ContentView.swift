import SwiftUI
import Mixtapes

struct ContentView: View {
    @Binding var selection: Selection
        
    // MARK: View
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                Group {
                    switch selection {
                    case .item:
                        ItemView(selection: $selection)
                            .frame(maxWidth: .maxWidth)
                    case .settings:
                        SettingsView(selection: $selection)
                            .frame(maxWidth: .maxWidth)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, minHeight: proxy.size.height, maxHeight: .infinity)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        ContentView(selection: .constant(.auto))
            .environmentObject(Mixtapes())
    }
}
