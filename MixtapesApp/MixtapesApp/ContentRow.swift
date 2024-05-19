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
                .padding(.horizontal, 1.5)
                .padding(.top, -4.0)
            content()
                .padding(.top)
        }
        .padding()
        .border(.red, width: 1.0)
    }
}

#Preview {
    ContentRow {
        
    }
}
