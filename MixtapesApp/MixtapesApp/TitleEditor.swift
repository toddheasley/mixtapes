import SwiftUI
import Mixtapes

struct TitleEditor: View {
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    
    // MARK: View
    var body: some View {
        DebounceEditor(mixtapes.index?.title) { text in
            mixtapes.index?.title = text
        }
        .disabled(mixtapes.index == nil)
    }
}

#Preview {
    TitleEditor()
        .environment(Mixtapes())
}
