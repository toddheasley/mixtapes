import SwiftUI
import Mixtapes

struct AuthorEditor: View {
    @EnvironmentObject private var mixtapes: Mixtapes
    
    private var url: URL? {
        return URL(string: mixtapes.index?.authors.first?.url ?? "")
    }
    
    private func changeURL(_ url: String) {
        guard !url.isEmpty else {
            mixtapes.index?.authors = []
            return
        }
        mixtapes.index?.authors = [Author(url, name: mixtapes.index?.authors.first?.name)]
    }
    
    private func changeName(_ name: String) {
        guard let url: String = mixtapes.index?.authors.first?.url,
              !url.isEmpty else {
            return
        }
        mixtapes.index?.authors = [Author(url, name: !name.isEmpty ? name : nil)]
    }
    
    // MARK: View
    var body: some View {
        VStack(spacing: .spacing) {
            HStack {
                DebounceEditor(mixtapes.index?.authors.first?.url, placeholder: "URL") { text in
                    changeURL(text)
                }
                LinkButton(url)
            }
            if let author: Author = mixtapes.index?.authors.first {
                DebounceEditor(author.name, placeholder: "Name") { text in
                    changeName(text)
                }
            }
        }
        .disabled(mixtapes.index == nil)
    }
}

struct AuthorEditor_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        AuthorEditor()
            .environmentObject(Mixtapes())
    }
}
