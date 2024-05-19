import SwiftUI
import Mixtapes

struct HomePageEditor: View {
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    private var url: URL? { URL(homepage: mixtapes.index?.homepage ?? "", path: "index.html") }
    
    // MARK: View
    var body: some View {
        HStack {
            DebounceEditor(mixtapes.index?.homepage, placeholder: "URL") { text in
                mixtapes.index?.homepage = text
            }
            .disabled(mixtapes.index == nil)
            LinkButton(url)
        }
    }
}

#Preview {
    HomePageEditor()
        .environment(Mixtapes())
}
