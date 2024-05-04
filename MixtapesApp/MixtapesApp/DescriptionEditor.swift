import SwiftUI
import Mixtapes

struct DescriptionEditor: View {
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    
    // MARK: View
    var body: some View {
        DebounceEditor(mixtapes.index?.description) { text in
            mixtapes.index?.description = text
        }
        .disabled(mixtapes.index == nil)
    }
}

#Preview {
    DescriptionEditor()
        .environment(Mixtapes())
}
