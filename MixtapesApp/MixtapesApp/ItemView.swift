import SwiftUI
import Mixtapes

struct ItemView: View {
    @Binding var selection: Selection
    
    // MARK: View
    var body: some View {
        if let item: Item = selection.item {
            VStack(spacing: 10.0) {
                HStack(alignment: .top, spacing: 10.0) {
                    ContentRow(label: "Image") {
                        ImageView(item: item)
                    }
                    .frame(width: .defaultLength + 20.0)
                    VStack(alignment: .leading, spacing: 10.0) {
                        ContentRow(label: "ID") {
                            Text(item.id)
                                .primaryStyle()
                        }
                        ContentRow(label: "Title") {
                            Text(item.title)
                                .primaryStyle()
                        }
                        ContentRow(label: "Summary") {
                            Text(item.summary)
                                .primaryStyle()
                        }
                        ContentRow(label: "Date") {
                            HStack {
                                DateEditor(selection: $selection)
                                ExplicitToggle(selection: $selection)
                            }
                        }
                    }
                }
                ContentRow(label: "Attachment") {
                    GroupBox {
                        
                    }
                }
            }
        }
    }
}
