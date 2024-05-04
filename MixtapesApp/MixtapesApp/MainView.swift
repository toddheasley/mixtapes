import SwiftUI
import Mixtapes

struct MainView: View {
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    @State private var selection: Selection = .auto
    
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
                .frame(minWidth: .maxWidth, maxWidth: .infinity, minHeight: 360.0, maxHeight: .infinity)
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
        .onChange(of: mixtapes.index) {
            guard mixtapes.index == nil else { return }
            selection = .auto
        }
    }
}

#Preview {
    MainView()
        .environment(Mixtapes())
}
