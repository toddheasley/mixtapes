import SwiftUI
import Mixtapes

struct ExplicitToggle: View {
    init(selection: Binding<Selection>) {
        _selection = selection
    }
    
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    @Binding private var selection: Selection
    
    private var i: Int? {
        guard let item: Item = selection.item else { return nil }
        return mixtapes.index?.items.firstIndex(of: item)
    }
    
    private var isExplicit: Bool {
        guard let i else { return false }
        return mixtapes.index!.items[i].metadata.isExplicit
    }
    
    private func toggleExplicit() {
        guard let i else { return }
        mixtapes.index?.items[i].metadata.isExplicit.toggle()
    }
    
    // MARK: View
    var body: some View {
        Button(action: toggleExplicit) {
            Image(systemName: isExplicit ? "e.square.fill" : "c.square")
                .opacity(isExplicit ? 0.9 : 0.2)
        }
        .help(isExplicit ? "Explicit" : "Clean")
        .disabled(i == nil)
    }
}

#Preview {
    ExplicitToggle(selection: .constant(.auto))
        .environment(Mixtapes())
}
