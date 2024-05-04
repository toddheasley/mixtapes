import SwiftUI
import Mixtapes

struct ContentView: View {
    init(selection: Binding<Selection>) {
        _selection = selection
    }
    
    @Binding private var selection: Selection
        
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

#Preview {
    ContentView(selection: .constant(.auto))
}
