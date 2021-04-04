import SwiftUI
import Mixtapes

struct TitleEditor: View {
    @EnvironmentObject private var mixtapes: Mixtapes
    
    // MARK: View
    var body: some View {
        DebounceEditor(mixtapes.index?.title) { text in
            mixtapes.index?.title = text
        }
        .disabled(mixtapes.index == nil)
    }
}

struct TitleEditor_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        TitleEditor()
            .environmentObject(Mixtapes())
    }
}
