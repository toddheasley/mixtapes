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
        if let item: Item = item {
            VStack(alignment: .leading, spacing: 10.0) {
                HStack(alignment: .top, spacing: 10.0) {
                    ImageView(item: item)
                    VStack(alignment: .leading, spacing: 10.0) {
                        Text("\(item.title)")
                        Text("\(item.summary)")
                    }
                }
                GroupBox(label: Label(title: { Text("Label") }, icon: {}), content: {
                    VStack {
                        ImageView(item: item)
                        Text("Content")
                    }
                })
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
