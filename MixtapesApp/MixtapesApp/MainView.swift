import SwiftUI
import Mixtapes

struct MainView: View {
    @State var selection: Selection = .auto
    
    // MARK: View
    var body: some View {
        NavigationView {
            SidebarView(selection: $selection)
                .frame(minWidth: 210.0, idealWidth: 320.0)
                .toolbar {
                    ToolbarItem {
                        SidebarToolbarItem()
                    }
                }
            ContentView(selection: $selection)
                .frame(minWidth: 540.0, maxWidth: .infinity, minHeight: 360.0, maxHeight: .infinity)
                .background(Color(.textBackgroundColor))
                .toolbar {
                    ToolbarItemGroup {
                        TitleToolbarItem()
                        Spacer()
                        ImportToolbarItem()
                        SettingsToolbarItem(selection: $selection)
                        FolderToolbarItem()
                        PreviewToolbarItem()
                    }
                }
        }
        .navigationTitle(selection.description)
    }
}

struct MainView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        MainView()
            .environmentObject(Mixtapes())
    }
}
