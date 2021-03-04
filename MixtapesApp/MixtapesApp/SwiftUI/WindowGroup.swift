import SwiftUI

extension WindowGroup {
    func hideTitlebar() -> some Scene {
        #if targetEnvironment(macCatalyst)
        for scene in UIApplication.shared.connectedScenes {
            (scene as? UIWindowScene)?.titlebar?.titleVisibility = .hidden
        }
        #endif
        return self
    }
}
