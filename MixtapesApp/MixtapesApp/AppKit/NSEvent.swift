import AppKit

extension NSEvent {
    static func keyboardShortcut(_ key: String, code: UInt16, modifiers: ModifierFlags = [.command]) -> NSEvent {
        return .keyEvent(with: .keyDown, location: .zero, modifierFlags: modifiers, timestamp: 0.0, windowNumber: 0, context: nil, characters: key.lowercased(), charactersIgnoringModifiers: key, isARepeat: false, keyCode: code)!
    }
}
