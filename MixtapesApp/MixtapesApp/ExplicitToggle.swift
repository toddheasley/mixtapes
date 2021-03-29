import SwiftUI
import Mixtapes

struct ExplicitToggle: View {
    @Binding var selection: Selection
    
    @EnvironmentObject private var mixtapes: Mixtapes
    
    private var i: Int? {
        guard let item: Item = selection.item else {
            return nil
        }
        return mixtapes.index?.items.firstIndex(of: item)
    }
    
    private var isExplicit: Bool {
        guard let i: Int = i else {
            return false
        }
        return mixtapes.index!.items[i].isExplicit
    }
    
    private func toggleExplicit() {
        guard let i: Int = i else {
            return
        }
        mixtapes.index?.items[i].isExplicit.toggle()
    }
    
    // MARK: View
    var body: some View {
        Button(action: toggleExplicit) {
            Image(systemName: isExplicit ? "e.square.fill" : "c.square")
                .resizable()
                .frame(width: 18.0, height: 18.0, alignment: .center)
        }
        .buttonStyle(PlainButtonStyle())
        .help(isExplicit ? "Explicit" : "Clean")
        .disabled(i == nil)
    }
}

struct ExplicitToggle_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        ExplicitToggle(selection: .constant(.auto))
    }
}
