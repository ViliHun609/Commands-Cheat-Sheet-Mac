import SwiftUI

struct CategoryRowView: View {
    let category: CheatSheetCategory
    @State private var isHovered = false

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: category.systemImageName)
                .foregroundColor(.accentColor)
                .imageScale(.large)
                .frame(width: 28, height: 28)
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
                .fill(isHovered ? Color.gray.opacity(0.15) : Color.clear)
                .padding(.horizontal, -4)
                .padding(.vertical, -4)
        )
        .onHover { hovering in
            self.isHovered = hovering
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isHovered)
    }
}
