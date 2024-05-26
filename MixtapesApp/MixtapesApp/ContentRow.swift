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
                .padding(.vertical, -3.5)
            content()
                .padding(.top)
        }
        .padding(10.0)
        .border(.tertiary.opacity(0.5), width: 0.5)
        .cornerRadius(1.0)
    }
}

#Preview {
    ContentRow {
        
    }
}
