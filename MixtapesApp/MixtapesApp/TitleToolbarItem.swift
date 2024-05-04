import SwiftUI
import Mixtapes

struct TitleToolbarItem: View {
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    
    private var title: String {
        return mixtapes.index?.title.description ?? App.title
    }
    
    // MARK: View
    var body: some View {
        Text(title)
            .primaryStyle()
            .padding(.horizontal, 5.0)
    }
}

#Preview {
    TitleToolbarItem()
        .environment(Mixtapes())
}
