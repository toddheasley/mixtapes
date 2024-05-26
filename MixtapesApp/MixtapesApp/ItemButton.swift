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
    
    // MARK: View
    var body: some View {
        Button(action: {
            selection = .item(item)
        }) {
            ZStack {
                FocusView(item.isSelected(selection))
                    .cornerRadius(5.5)
                ArtworkView(item: item)
                    .padding(3.0)
            }
            .frame(minWidth: 64.0, idealWidth: 128.0, maxWidth: 192.0)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

private struct FocusView: View {
    let isFocused: Bool
    
    init(_ isFocused: Bool) {
        self.isFocused = isFocused
    }
    
    // MARK: View
    var body: some View {
        Rectangle()
            .fill(Color.focus(isFocused))
    }
}

private extension Color {
    static func focus(_ isFocused: Bool) -> Self {
        accentColor.opacity(isFocused ? 0.33 : 0.0)
    }
}

private extension Item {
    func isSelected(_ selection: Selection) -> Bool {
        switch selection {
        case .item(let item):
            return self == item
        default:
            return false
        }
    }
}
