import AppKit

extension NSWindow {
    func toggleSidebar() {
        firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
    
    func toggleSettings() {
        firstResponder?.performKeyEquivalent(with: .keyboardShortcut(",", code: 43, modifiers: [.command, .option]))
    }
    
    func importAudio() {
        firstResponder?.performKeyEquivalent(with: .keyboardShortcut("N", code: 45, modifiers: [.command, .option]))
    }
    
    func showInFinder() {
        firstResponder?.performKeyEquivalent(with: .keyboardShortcut("o", code: 31))
    }
    
    func preview() {
        firstResponder?.performKeyEquivalent(with: .keyboardShortcut("O", code: 31, modifiers: [.command, .option]))
    }
}
