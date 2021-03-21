import SwiftUI
import Mixtapes

extension Alert {
    init(error: Error, action: @escaping () -> Void) {
        self.init(title: Text("Error"), message: Text(error.description), dismissButton: .default(Text("OK"), action: action))
    }
}
