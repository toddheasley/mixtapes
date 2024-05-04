import SwiftUI
import Mixtapes

struct AuthorEditor: View {
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    
    private var url: URL? { URL(string: mixtapes.index?.authors.first?.url ?? "") }
    
    private func changeURL(_ url: String) {
        mixtapes.index?.authors = !url.isEmpty ? [Author(mixtapes.index?.authors.first?.name, url: url)] : []
    }
    
    private func changeName(_ name: String) {
        guard let url: String = mixtapes.index?.authors.first?.url,
              !url.isEmpty else {
            return
        }
        mixtapes.index?.authors = [Author(!name.isEmpty ? name : nil, url: url)]
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

#Preview {
    AuthorEditor()
        .environment(Mixtapes())
}
