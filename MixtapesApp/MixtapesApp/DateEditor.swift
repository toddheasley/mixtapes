import SwiftUI
import Mixtapes

struct DateEditor: View {
    init(selection: Binding<Selection>) {
        _selection = selection
    }
    
    @Environment(Mixtapes.self) private var mixtapes: Mixtapes
    @Binding private var selection: Selection
    @State private var date: Date = Date()
    
    private var i: Int? {
        guard let item: Item = selection.item else { return nil }
        return mixtapes.index?.items.firstIndex(of: item)
    }
    
    private func changeDate(_ date: Date? = nil) {
        guard let i else { return }
        if let date: Date = date {
            mixtapes.index?.items[i].metadata.published = date
        } else {
            self.date = mixtapes.index!.items[i].metadata.published
        }
    }
    
    // MARK: View
    var body: some View {
        DatePicker("", selection: $date)
            .padding(.leading, -8.0)
            .padding(.trailing, 10.0)
            .onAppear {
                changeDate()
            }
            .onChange(of: selection) {
                changeDate()
            }
            .onChange(of: date) {
                changeDate(date)
            }
            .disabled(i ==  nil)
    }
}

#Preview {
    DateEditor(selection: .constant(.auto))
        .environment(Mixtapes())
}
