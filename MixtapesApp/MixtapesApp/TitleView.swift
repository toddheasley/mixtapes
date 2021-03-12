import SwiftUI
import Mixtapes

struct TitleView: View {
    @EnvironmentObject private var mixtapes: Mixtapes
    
    private var title: String {
        return mixtapes.index?.title.description ?? "Mixtapes"
    }
    
    // MARK: View
    var body: some View {
        HStack {
            IconView(mixtapes.index?.icon, size: CGSize(width: 21.0, height: 21.0))
                .cornerRadius(3.0)
                .padding(.trailing, 6.0)
            Text(title)
                .bodyStyle()
        }
    }
}
