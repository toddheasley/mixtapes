import SwiftUI
import Mixtapes

struct ItemButton: View {
    init(_ item: Item, selection: Binding<Selection>) {
        _selection = selection
        self.item = item
    }
    
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    @Binding private var selection: Selection
    @State private var item: Item
    
    private var isSelected: Bool {
        switch selection {
        case .item(let item):
            return item == self.item
        default:
            return false
        }
    }
    
    private func selectItem() {
        selection = .item(item)
    }
    
    // MARK: View
    var body: some View {
        Button(action: selectItem) {
            Text("\(item.title)")
                .primaryStyle()
                .padding(.horizontal, 1.0)
                .padding(.vertical, 2.0)
                .background(Color.highlightColor(isSelected))
        }
        .buttonStyle(PlainButtonStyle())
    }
}
