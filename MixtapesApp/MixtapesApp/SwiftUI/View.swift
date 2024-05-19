import SwiftUI
import Mixtapes

extension View {
    func alert(error: Binding<Error?>, action: @escaping () -> Void = {}) -> some View {
        alert(item: error) { error in
            Alert(title: Text("Error"), message: Text(error.description), dismissButton: .default(Text("OK"), action: action))
        }
    }
}
