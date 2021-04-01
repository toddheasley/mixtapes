import SwiftUI
import Mixtapes

struct ItemButton: View {
    @State var item: Item
    @Binding var selection: Selection
    
    @EnvironmentObject private var mixtapes: Mixtapes
    
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
