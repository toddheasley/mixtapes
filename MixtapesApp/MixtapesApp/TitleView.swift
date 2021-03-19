import SwiftUI
import Mixtapes

struct TitleView: View {
    @EnvironmentObject private var mixtapes: Mixtapes
    
    private var title: String {
        return mixtapes.index?.title.description ?? "Mixtapes"
    }
    
    // MARK: View
    var body: some View {
        Text(title)
            .bodyStyle()
            .padding(.horizontal, 5.0)
    }
}

struct TitleView_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        TitleView()
            .environmentObject(Mixtapes())
    }
}
