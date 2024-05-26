import SwiftUI
import Mixtapes

@main
struct App: SwiftUI.App {
    static let title: String = "Mixtapes"
    @State private var mixtapes: Mixtapes = Mixtapes()
    
    // MARK: App
    var body: some Scene {
        WindowGroup(Self.title) {
            MainView()
                .environment(mixtapes)
                .alert(error: $mixtapes.error) {
                    mixtapes.error = nil
                }
        }
        .windowToolbarStyle(UnifiedWindowToolbarStyle(showsTitle: false))
        .commands {
            CommandGroup(replacing: .appSettings) {
                SettingsCommands()
                    .environment(mixtapes)
            }
            CommandGroup(after: CommandGroupPlacement.newItem) {
                FileCommands()
                    .environment(mixtapes)
            }
            SidebarCommands()
            CommandGroup(replacing: .help) {
                HelpCommands()
            }
        }
    }
}
