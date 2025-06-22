import SwiftUI

struct CategoryItemsView: View {
    let category: CheatSheetCategory
    @State private var searchText = ""

    var filteredItems: [CheatSheetItem] {
        if searchText.isEmpty {
            return category.items
        } else {
            return category.items.filter { item in
                item.name.localizedCaseInsensitiveContains(searchText) ||
                item.code.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            
            TextField("Search Items", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .padding(.vertical, 8)

            List {
                ForEach(filteredItems) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.code)
                                .font(.system(.caption, design: .monospaced))
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(4)
                                .foregroundColor(.primary)
                        }
                        .padding(.vertical, 2)

                        Spacer()

                        AnimatedCopyButton {
                            copyToClipboard(text: item.code)
                        }
                        .padding(.leading, 4)
                    }
                }
            }
            .padding()
            .scrollIndicators(.never)
            .navigationTitle(category.name)
            .listStyle(PlainListStyle())
        }
    }

    private func copyToClipboard(text: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(text, forType: .string)
        print("Copied to clipboard: \(text)")
    }
}

#if DEBUG
struct CategoryItemsView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleCategories = DataService.loadCheatSheets()
        
        if let firstCategory = sampleCategories.first {
            CategoryItemsView(category: firstCategory)
        } else {
            Text("No sample category data found for preview.")
        }
    }
}
#endif
