import SwiftUI
import Mixtapes

struct HomePageEditor: View {
    @EnvironmentObject private var mixtapes: Mixtapes
    
    private var url: URL? {
        return URL(homepage: mixtapes.index?.homepage ?? "", path: "index.html")
    }
    
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

struct HomePageEditor_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        HomePageEditor()
            .environmentObject(Mixtapes())
    }
}
