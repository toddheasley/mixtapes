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
        if mixtapes.index != nil {
            VStack {
                ContentRow("Home Page") {
                    HomePageEditor()
                }
                HStack(alignment: .top) {
                    ContentRow("Icon") {
                        ZStack(alignment: .topTrailing) {
                            IconButton()
                            DeleteButton(selection: $selection)
                                .padding(5.5)
                        }
                    }
                    VStack(alignment: .leading) {
                        ContentRow("Title") {
                            TitleEditor()
                        }
                        ContentRow("Description") {
                            DescriptionEditor()
                        }
                        ContentRow("Author") {
                            AuthorEditor()
                        }
                        ContentRow("Folder") {
                            FolderButton()
                        }
                    }
                }
            }
        } else {
            FolderButton()
                .padding()
                .buttonStyle(.bordered)
            
        }
    }
}

#Preview {
    SettingsView(selection: .constant(.auto))
        .environment(Mixtapes())
}
