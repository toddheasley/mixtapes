import SwiftUI
import Mixtapes

struct SettingsView: View {
    init(selection: Binding<Selection>) {
        _selection = selection
    }
    
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    @Binding private var selection: Selection
    
    // MARK: View
    var body: some View {
        if let _: Index = mixtapes.index {
            VStack(spacing: .spacing) {
                ContentRow(label: "Home Page") {
                    HomePageEditor()
                }
                HStack(alignment: .top, spacing: .spacing) {
                    GroupBox {
                        ContentRow(label: "Icon") {
                            ZStack(alignment: .topTrailing) {
                                IconButton()
                                DeleteButton(selection: $selection)
                            }
                        }
                        .padding(.top, -6.0)
                    }
                    .clipped()
                    .frame(width: .defaultLength + (.spacing * 2.0))
                    VStack(alignment: .leading, spacing: .spacing) {
                        ContentRow(label: "Title") {
                            TitleEditor()
                        }
                        ContentRow(label: "Description") {
                            DescriptionEditor()
                        }
                        ContentRow(label: "Author") {
                            AuthorEditor()
                        }
                        ContentRow(label: "Folder") {
                            FolderButton()
                                .padding(3.0)
                        }
                    }
                }
            }
        } else {
            FolderButton()
        }
    }
}

#Preview {
    SettingsView(selection: .constant(.auto))
        .environment(Mixtapes())
}
