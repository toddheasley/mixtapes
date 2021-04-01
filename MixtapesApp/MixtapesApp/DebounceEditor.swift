import SwiftUI
import Combine
import Mixtapes

struct DebounceEditor: View {
    init(_ text: String? = nil, placeholder: String = "", action: @escaping (String) -> Void) {
        _text = .init(initialValue: text ?? "")
        self.placeholder = placeholder
        self.action = action
    }
    
    @State private var text: String
    @State private var subscriber: AnyCancellable?
    
    private let placeholder: String
    private let action: (String) -> Void
    
    // MARK: View
    var body: some View {
        TextField(placeholder, text: $text)
            .onChange(of: text) { _ in
                subscriber?.cancel()
                subscriber = CurrentValueSubject<String, Never>(text)
                    .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
                    .sink { text in
                        action(text)
                    }
            }
    }
}

struct DebounceEditor_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        DebounceEditor { _ in
            
        }
        .environmentObject(Mixtapes())
    }
}
