import SwiftUI

struct ContentRow<Content>: View where Content: View {
    let content: () -> Content
    let label: String?
    
    init(_ label: String? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.label = label
    }
    
    // MARK: View
    var body: some View {
        ZStack(alignment: .topLeading) {
            Divider()
                .hidden()
            Text(label ?? "")
                .secondary()
                .padding(.horizontal, 2.0)
                .padding(.vertical, -1.0)
            content()
                .padding(.top)
        }
        .padding(5.0)
        .cornerRadius(1.0)
    }
}

#Preview {
    ContentRow {
        
    }
}
