import SwiftUI
import Mixtapes

struct DescriptionEditor: View {
    @EnvironmentObject private var mixtapes: Mixtapes
    
    // MARK: View
    var body: some View {
        DebounceEditor(mixtapes.index?.description) { text in
            mixtapes.index?.description = text
        }
        .disabled(mixtapes.index == nil)
    }
}

struct DescriptionEditor_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        DescriptionEditor()
            .environmentObject(Mixtapes())
    }
}
