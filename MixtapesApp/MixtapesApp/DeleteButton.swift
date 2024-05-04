import SwiftUI
import Mixtapes

struct DeleteButton: View {
    init(selection: Binding<Selection>) {
        _selection = selection
    }
    
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    @Binding private var selection: Selection
    @State private var isPresented: Bool = false
    
    private var i: Int? {
        guard let item: Item = selection.item else { return nil }
        return mixtapes.index?.items.firstIndex(of: item)
    }
    
    private var isDisabled: Bool {
        switch selection {
        case .item:
            return i == nil
        case .settings:
            return mixtapes.index?.icon.isDefault ?? true
        }
    }
    
    private var title: String { "\(help)?" }
    
    private var message: String {
        switch selection {
        case .item(let item):
            return "Remove \"\(item.attachment.url.lastPathComponent)\" from podcast"
        case .settings:
            return "Revert to default icon"
        }
    }
    
    private var help: String {
        switch selection {
        case .item:
            return "Delete Mixtape"
        case .settings:
            return "Delete Icon"
        }
    }
    
    private func presentAlert() {
        isPresented = selection.item != nil || !(mixtapes.index?.icon.isDefault ?? true)
    }
    
    private func delete() {
        if let i: Int = i {
            mixtapes.index?.items.remove(at: i)
            selection = .auto
        } else {
            try? mixtapes.index?.icon.reset()
        }
    }
    
    // MARK: View
    var body: some View {
        Button(action: presentAlert) {
            Image(systemName: "trash")
        }
        .alert(isPresented: $isPresented) {
            Alert(title: Text(title), message: Text(message), primaryButton: .destructive(Text("Delete"), action: delete), secondaryButton: .cancel())
        }
        .help(help)
        .keyboardShortcut(.delete)
        .opacity(isDisabled ? 0.0 : 1.0)
        .disabled(isDisabled)
    }
}
