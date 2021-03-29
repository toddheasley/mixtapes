import SwiftUI
import Mixtapes

@main
struct App: SwiftUI.App {
    static let title: String = "Mixtapes"
    
    @StateObject private var mixtapes: Mixtapes = Mixtapes()
    
    // MARK: App
    var body: some Scene {
        WindowGroup(Self.title) {
            MainView()
                .environmentObject(mixtapes)
                .alert(error: $mixtapes.error) {
                    mixtapes.error = nil
                }
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
