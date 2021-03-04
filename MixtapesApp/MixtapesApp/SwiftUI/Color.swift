import SwiftUI

extension Color {
    static var background: Self {
        return Self("BackgroundColor")
    }
    
    static var foreground: Self {
        return Self("ForegroundColor")
    }
    
    static var highlight: Self {
        return accentColor.opacity(0.5)
    }
}
