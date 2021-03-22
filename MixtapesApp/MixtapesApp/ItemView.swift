import SwiftUI
import Mixtapes

struct ItemView: View {
    @Binding var selection: Selection
    @EnvironmentObject private var mixtapes: Mixtapes
    
    private var item: Item? {
        switch selection {
        case .item(let item):
            return item
        default:
            return nil
        }
    }
    
    // MARK: View
    var body: some View {
        ImageView(item: item)
    }
}
