import SwiftUI
import Mixtapes

struct TitleToolbarItem: View {
    @EnvironmentObject private var mixtapes: Mixtapes
    
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

struct TitleToolbarItem_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        TitleToolbarItem()
            .environmentObject(Mixtapes())
    }
}
