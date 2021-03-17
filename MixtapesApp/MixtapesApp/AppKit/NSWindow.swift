import AppKit

extension NSWindow {
    func toggleSidebar() {
        firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
    
    func toggleSettings() {
        firstResponder?.performKeyEquivalent(with: .settingsEvent)
    }
}
