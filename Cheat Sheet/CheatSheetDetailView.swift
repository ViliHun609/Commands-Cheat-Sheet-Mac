import SwiftUI

struct CheatSheetDetailView: View {
    let item: CheatSheetItem
    @State private var isCopyButtonHovered = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(item.name)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    copyToClipboard(text: item.code)
                }) {
                    Label("Copy", systemImage: "doc.on.doc")
                        .foregroundColor(isCopyButtonHovered ? Color.accentColor : Color.blue)
                        .scaleEffect(isCopyButtonHovered ? 1.1 : 1.0)
                        .animation(.spring(response: 0.25, dampingFraction: 0.5), value: isCopyButtonHovered)
                }
                .buttonStyle(PlainButtonStyle())
                .onHover { hovering in
                    self.isCopyButtonHovered = hovering
                }
            }
            
            Divider()
            
            ScrollView {
                Text(item.code)
                    .font(.system(.body, design: .monospaced))
                    .padding(.top, 5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textSelection(.enabled)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .navigationTitle(item.name)
    }

    private func copyToClipboard(text: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(text, forType: .string)
        print("Copied to clipboard: \(text)")
    }
}

#if DEBUG
struct CheatSheetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheatSheetDetailView(item: CheatSheetItem(name: "Sample Item", code: "Sample code snippet\nAnother line of code;"))
        }
        .frame(width: 300, height: 200)
    }
}
#endif
