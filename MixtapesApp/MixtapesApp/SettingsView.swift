import SwiftUI
import Mixtapes

struct SettingsView: View {
    @Binding var selection: Selection
    
    @EnvironmentObject private var mixtapes: Mixtapes
    
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

struct SettingsView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        SettingsView(selection: .constant(.auto))
            .environmentObject(Mixtapes())
    }
}
