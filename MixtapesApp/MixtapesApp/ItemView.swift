import SwiftUI
import Mixtapes

struct ItemView: View {
    @State var item: Item
    @EnvironmentObject private var mixtapes: Mixtapes
    
    // MARK: View
    var body: some View {
        Image(systemName: "play.rectangle")
    }
}
