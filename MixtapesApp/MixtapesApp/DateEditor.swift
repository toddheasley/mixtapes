import SwiftUI
import Mixtapes

struct DateEditor: View {
    @Binding var selection: Selection
    
    @State private var date: Date = Date()
    @EnvironmentObject private var mixtapes: Mixtapes
    
    private var i: Int? {
        guard let item: Item = selection.item else {
            return nil
        }
        return mixtapes.index?.items.firstIndex(of: item)
    }
    
    private func changeDate(_ date: Date? = nil) {
        guard let i: Int = i else {
            return
        }
        if let date: Date = date {
            mixtapes.index?.items[i].date.published = date
        } else {
            self.date = mixtapes.index!.items[i].date.published
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
            .onChange(of: selection) { _ in
                changeDate()
            }
            .onChange(of: date) { date in
                changeDate(date)
            }
            .disabled(i ==  nil)
    }
}

struct DateEditor_Previews: PreviewProvider {
    
    // MARK: PreviewProvider
    static var previews: some View {
        DateEditor(selection: .constant(.auto))
            .environmentObject(Mixtapes())
    }
}
