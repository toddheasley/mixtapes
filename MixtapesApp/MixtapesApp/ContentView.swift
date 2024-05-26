import SwiftUI
import Mixtapes

struct ContentView: View {
    init(selection: Binding<Selection>) {
        _selection = selection
    }
    
    @Binding private var selection: Selection
        
    // MARK: View
    var body: some View {
        ScrollView {
            HStack {
                Spacer()
                Group {
                    switch selection {
                    case .item:
                        ItemView(selection: $selection)
                    case .settings:
                        SettingsView(selection: $selection)
                    }
                }
                .frame(maxWidth: 640.0)
                .padding()
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView(selection: .constant(.auto))
}
