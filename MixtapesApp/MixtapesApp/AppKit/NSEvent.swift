import AppKit

extension NSEvent {
    static var settingsEvent: NSEvent {
        return .keyEvent(with: .keyDown, location: .zero, modifierFlags: .command, timestamp: 0.0, windowNumber: 0, context: nil, characters: ",", charactersIgnoringModifiers: ",", isARepeat: false, keyCode: 43)!
    }
}
