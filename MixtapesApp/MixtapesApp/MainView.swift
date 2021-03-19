import SwiftUI
import Mixtapes

struct MainView: View {
    @State private var item: Item?
    
    // MARK: View
    var body: some View {
        NavigationView {
            SidebarView(item: $item)
                .frame(minWidth: 210.0, idealWidth: 320.0)
                .toolbar {
                    ToolbarItem {
                        SidebarButton()
                    }
                }
            ContentView(item: item)
                .frame(minWidth: 320.0, idealWidth: 540.0, maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
                .background(Color(.textBackgroundColor))
                .toolbar {
                    ToolbarItemGroup {
                        TitleView()
                        Spacer()
                        ItemButton()
                        SettingsButton(item: $item)
                        FinderButton()
                        PreviewButton()
                    }
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        MainView()
            .environmentObject(Mixtapes())
    }
}
