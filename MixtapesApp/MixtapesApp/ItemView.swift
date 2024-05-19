import SwiftUI
import Mixtapes

struct ItemView: View {
    init(selection: Binding<Selection>) {
        _selection = selection
    }
    
    @Binding private var selection: Selection
    
    // MARK: View
    var body: some View {
        if let item: Item = selection.item {
            VStack {
                HStack(alignment: .top) {
                    ContentRow("Image") {
                        ArtworkView(item: item)
                            .shadow(radius: 1.0)
                            .padding(1.0)
                    }
                    VStack(alignment: .leading) {
                        ContentRow("Title") {
                            HStack {
                                Text(item.title)
                                    .primary()
                                Spacer()
                                DeleteButton(selection: $selection)
                            }
                        }
                        ContentRow("Summary") {
                            Text(item.summary)
                                .primary()
                        }
                        ContentRow("Date") {
                            HStack {
                                DateEditor(selection: $selection)
                                Spacer()
                                ExplicitToggle(selection: $selection)
                            }
                        }
                        ContentRow("File") {
                            HStack {
                                Text(item.attachment.mimeType)
                                    .primary()
                                Spacer()
                                Text(item.attachment.asset.duration.timestamp)
                                    .primary()
                            }
                        }
                    }
                }
                if item.attachment.asset.chapters.count > 1 {
                    ContentRow("Chapters") {
                        VStack(alignment: .leading) {
                            ForEach(item.attachment.asset.chapters) { chapter in
                                ContentRow(chapter.id) {
                                    HStack {
                                        Text(chapter.title)
                                            .primary()
                                        Spacer()
                                        Text(chapter.duration?.lowerBound.timestamp ?? "")
                                            .primary()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
