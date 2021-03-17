import SwiftUI
import Mixtapes

struct ContentView: View {
    @State var item: Item?
    
    // MARK: View
    var body: some View {
        if let item: Item = item {
            ItemView(item: item)
        } else {
            SettingsView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        ContentView()
            .environmentObject(Mixtapes())
    }
}
