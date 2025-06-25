import AppKit
import SwiftUI

struct CategoryRowView: View {
    let category: CheatSheetCategory
    @State private var isHovered = false

    private var currentImageName: String {
        guard isHovered else {
            return category.systemImageName
        }
        let baseName = category.systemImageName
        if baseName.hasSuffix(".fill") {
            return baseName
        }
        let potentialFilledName = "\(baseName).fill"
        if NSImage(systemSymbolName: potentialFilledName, accessibilityDescription: nil) != nil {
            return potentialFilledName
        } else {
            return baseName
        }
    }

    var body: some View {
          HStack(spacing: 12) {
              Image(systemName: currentImageName)
                  .foregroundColor(isHovered ? .accentColor : .gray)
                  .imageScale(.large)
                  .frame(width: 32, height: 32)
                  .padding(.leading, 2)

            VStack(alignment: .leading) {
                Text(category.name)
                    .font(.headline)
                Text(category.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 8)
        .scaleEffect(isHovered ? 1.02 : 1.0)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.clear)
                .padding(.horizontal, -4)
                .padding(.vertical, -4)
        )
        .onHover { hovering in
            self.isHovered = hovering
        }
        .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isHovered)
    }
}

#Preview {
    CategoryRowView(category: CheatSheetCategory(name: "Sample Category", systemImageName: "star", subtitle: "This is a sample subtitle for preview.", items: []))
}
