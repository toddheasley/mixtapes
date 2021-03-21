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
                        SidebarButton()
                    }
                }
            ContentView(selection: $selection)
                .frame(minWidth: 320.0, idealWidth: 540.0, maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
                .background(Color(.textBackgroundColor))
                .toolbar {
                    ToolbarItemGroup {
                        TitleView()
                        Spacer()
                        ImportButton()
                        SettingsButton(selection: $selection)
                        FinderButton()
                        PreviewButton()
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
