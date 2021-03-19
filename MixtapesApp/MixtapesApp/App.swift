import SwiftUI
import Mixtapes

@main
struct App: SwiftUI.App {
    @StateObject private var mixtapes: Mixtapes = Mixtapes()
    
    // MARK: App
    var body: some Scene {
        WindowGroup("Mixtapes") {
            MainView()
                .environmentObject(mixtapes)
        }
        .windowToolbarStyle(UnifiedWindowToolbarStyle(showsTitle: false))
        .commands {
            CommandGroup(replacing: .appSettings) {
                SettingsCommands()
                    .environmentObject(mixtapes)
            }
            CommandGroup(after: CommandGroupPlacement.newItem) {
                FileCommands()
                    .environmentObject(mixtapes)
            }
            SidebarCommands()
            CommandGroup(replacing: .help) {
                HelpCommands()
            }
        }
    }
}
