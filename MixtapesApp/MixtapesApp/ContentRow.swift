import SwiftUI

struct ContentRow<Content>: View where Content: View {
    let content: () -> Content
    let label: String?
    
    init(label: String? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.label = label
    }
    
    // MARK: View
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading) {
                Divider()
                Text(label ?? "")
                    .secondaryStyle()
                    .padding(.leading, 1.0)
                    .padding(.top, -8.0)
            }
            content()
                .padding(.top, 15.0)
                .padding(.horizontal, 10.0)
                .padding(.bottom, 5.0)
        }
    }
}

struct ContentRow_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        ContentRow {
            
        }
    }
}
