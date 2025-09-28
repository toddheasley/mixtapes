import SwiftUI
import Mixtapes

struct TitleToolbarItem: View {
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    private var title: String { mixtapes.index?.title.description ?? App.title }
    
    // MARK: View
    var body: some View {
        Text(title)
            .primary()
            .padding(.horizontal)
    }
}

#Preview {
    TitleToolbarItem()
        .environment(Mixtapes())
}
