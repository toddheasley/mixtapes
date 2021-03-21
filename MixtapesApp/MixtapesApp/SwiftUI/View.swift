import SwiftUI
import Mixtapes

extension View {
    func alert(error: Binding<Error?>, action: @escaping () -> Void = {}) -> some View {
        return alert(item: error) { error in
            Alert(error: error, action: action)
        }
    }
}
