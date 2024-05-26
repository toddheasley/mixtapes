import SwiftUI
import Mixtapes

extension Mixtapes {
    static func toggleSettings() {
        NSApplication.shared.keyWindow?.toggleSettings()
    }
    
    static func toggleSidebar() {
        NSApplication.shared.keyWindow?.toggleSidebar()
    }
    
    static func viewSource() {
        NSWorkspace.shared.open(.source)
    }
    
    func openFolder(_ message: String?, prompt: String?) {
        NSOpenPanel.openFolder(message, prompt: prompt) { url in
            self.open(url)
        }
    }
    
    func importAudio(_ message: String?, prompt: String?) {
        NSOpenPanel.importAudio(message, prompt: prompt) { url in
            self.importItem(url)
        }
    }
    
    func importIcon(_ message: String?, prompt: String?) {
        NSOpenPanel.importIcon(message, prompt: prompt) { url in
            self.importIcon(url)
        }
    }
    
    func showInFinder() {
        guard let url: URL = index?.url.deletingLastPathComponent() else { return }
        NSWorkspace.shared.open(url)
    }
    
    func preview() {
        guard let url: URL = index?.url.deletingPathExtension() else { return }
        NSWorkspace.shared.open(url.appendingPathExtension("html"))
    }
    
    func forget() {
        open(nil)
    }
}

private extension URL {
    static let source: Self = Self(string: "https://github.com/toddheasley/mixtapes")!
}

private extension NSWindow {
    func toggleSettings() {
        performKeyEquivalent(with: .keyboardShortcut(",", code: 43, modifiers: [.command, .option]))
    }
    
    func toggleSidebar() {
        tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}

private extension NSOpenPanel {
    static func openFolder(_ message: String?, prompt: String?, handler: @escaping (URL?) -> Void) {
        let panel: Self = Self()
        panel.message = message
        panel.prompt = prompt
        panel.canCreateDirectories = true
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.begin { response in
            guard response == .OK else { return }
            handler(panel.url)
        }
    }
    
    static func importAudio(_ message: String?, prompt: String?, handler: @escaping (URL?) -> Void) {
        let panel: Self = Self()
        panel.message = message
        panel.prompt = prompt
        panel.allowedContentTypes = Asset.contentTypes
        panel.canChooseFiles = true
        panel.begin { response in
            guard response == .OK else { return }
            handler(panel.url)
        }
    }
    
    static func importIcon(_ message: String?, prompt: String?, handler: @escaping (URL?) -> Void) {
        let panel: Self = Self()
        panel.message = message
        panel.prompt = prompt
        panel.allowedContentTypes = Icon.contentTypes
        panel.canChooseFiles = true
        panel.begin { response in
            guard response == .OK else { return }
            handler(panel.url)
        }
    }
}

private extension NSEvent {
    static func keyboardShortcut(_ key: String, code: UInt16, modifiers: ModifierFlags = .command) -> NSEvent {
        keyEvent(with: .keyDown, location: .zero, modifierFlags: modifiers, timestamp: 0.0, windowNumber: 0, context: nil, characters: key.lowercased(), charactersIgnoringModifiers: key, isARepeat: false, keyCode: code)!
    }
}
