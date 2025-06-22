import SwiftUI

struct CategoryItemsView: View {
    let category: CheatSheetCategory

    var body: some View {
        List {
            ForEach(category.items) { item in                
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
                        .padding(.trailing, 8)
                    }
            }
        }
        .padding(.horizontal)
        .navigationTitle(category.name)
        .listStyle(PlainListStyle())
        .padding(.bottom, 16)
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
            NavigationView {
                CategoryItemsView(category: firstCategory)
            }
        } else {
            Text("No sample category data found for preview.")
        }
    }
}
#endif
