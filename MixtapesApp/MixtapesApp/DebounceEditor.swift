import SwiftUI
import Combine
import Mixtapes

struct DebounceEditor: View {
    init(_ text: String? = nil, placeholder: String = "", action: @escaping (String) -> Void) {
        _text = .init(initialValue: text ?? "")
        self.placeholder = placeholder
        self.action = action
    }
    
    @State private var subscriber: AnyCancellable?
    @State private var text: String
    private let placeholder: String
    private let action: (String) -> Void
    
    // MARK: View
    var body: some View {
        TextField(placeholder, text: $text)
            .onChange(of: text) {
                subscriber?.cancel()
                subscriber = CurrentValueSubject<String, Never>(text)
                    .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
                    .sink { action($0) }
            }
    }
}

#Preview {
    DebounceEditor { _ in }
}
