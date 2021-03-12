import SwiftUI
import Mixtapes

@main
struct App: SwiftUI.App {
    @StateObject private var mixtapes: Mixtapes = Mixtapes()
    
    // MARK: App
    var body: some Scene {
        WindowGroup("Mixtapes") {
            NavigationView {
                SidebarView()
                    .frame(minWidth: 210.0, idealWidth: 320.0)
                    .toolbar {
                        SidebarButton()
                    }
                ContentView()
                    .background(Color(.textBackgroundColor))
                    .frame(minWidth: 320.0, idealWidth: 540.0, maxWidth: .greatestFiniteMagnitude)
                    .toolbar {
                        ToolbarItem(placement: .navigation) {
                            TitleView()
                        }
                    }
            }
            .environmentObject(mixtapes)
        }
        .windowToolbarStyle(UnifiedWindowToolbarStyle(showsTitle: false))
        .commands {
            SidebarCommands()
            CommandGroup(replacing: .help) {
                HelpButton()
            }
        }
    }
}
