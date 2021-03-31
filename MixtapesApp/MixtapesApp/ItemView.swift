import SwiftUI
import Mixtapes

struct ItemView: View {
    @Binding var selection: Selection
    
    // MARK: View
    var body: some View {
        if let item: Item = selection.item {
            VStack(spacing: .spacing) {
                HStack(alignment: .top, spacing: .spacing) {
                    ContentRow(label: "Image") {
                        ImageView(item: item)
                    }
                    .frame(width: .defaultLength + (.spacing * 2.0))
                    VStack(alignment: .leading, spacing: .spacing) {
                        ContentRow(label: "Title") {
                            HStack {
                                Text(item.title)
                                .primaryStyle()
                                Spacer()
                                DeleteButton(selection: $selection)
                            }
                        }
                        ContentRow(label: "Summary") {
                            Text(item.summary)
                                .primaryStyle()
                        }
                        ContentRow(label: "Date") {
                            HStack {
                                DateEditor(selection: $selection)
                                ExplicitToggle(selection: $selection)
                            }
                        }
                        ContentRow(label: "File") {
                            HStack(spacing: .spacing) {
                                Text(item.attachment.mimeType)
                                    .primaryStyle()
                                Spacer()
                                Text(item.attachment.asset.duration.timestamp)
                                    .primaryStyle()
                            }
                        }
                    }
                }
                if item.attachment.asset.chapters.count > 1 {
                    GroupBox {
                        VStack(alignment: .leading, spacing: .spacing) {
                            ContentRow(label: "Chapters") {
                                
                            }
                            .padding(.bottom, 6.0)
                            .padding(.top, -6.0)
                            ForEach(item.attachment.asset.chapters) { chapter in
                                ContentRow(label: chapter.id) {
                                    HStack(spacing: .spacing) {
                                        Text(chapter.title)
                                            .primaryStyle()
                                        Spacer()
                                        Text(chapter.duration?.lowerBound.timestamp ?? "")
                                            .primaryStyle()
                                    }
                                }
                            }
                        }
                    }
                    .clipped()
                }
            }
        }
    }
}
