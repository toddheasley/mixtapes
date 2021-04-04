import AppKit

extension NSWindow {
    func toggleSidebar() {
        tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
    
    func toggleSettings() {
        performKeyEquivalent(with: .keyboardShortcut(",", code: 43, modifiers: [.command, .option]))
    }
    
    func importAudio() {
        performKeyEquivalent(with: .keyboardShortcut("N", code: 45, modifiers: [.command, .option]))
    }
    
    func showInFinder() {
        performKeyEquivalent(with: .keyboardShortcut("o", code: 31))
    }
    
    func preview() {
        performKeyEquivalent(with: .keyboardShortcut("O", code: 31, modifiers: [.command, .option]))
    }
}
