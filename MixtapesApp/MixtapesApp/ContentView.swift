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
                    case .settings:
                        SettingsView()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, minHeight: proxy.size.height, maxHeight: .infinity)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static private var selection: Selection = .auto
    
    // MARK: PreviewProvider
    static var previews: some View {
        ContentView(selection: $selection)
            .environmentObject(Mixtapes())
    }
}
