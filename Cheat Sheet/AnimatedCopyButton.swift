import SwiftUI

struct AnimatedCopyButton: View {
    let action: () -> Void
    @State private var isHovered = false

    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Label("Copy", systemImage: "doc.on.doc")
                    .labelStyle(.iconOnly)
                    .foregroundColor(isHovered ? Color.accentColor : Color.secondary)
                    .scaleEffect(isHovered ? 1.15 : 1.0)
                    .rotationEffect(.degrees(isHovered ? -10 : 0))
                
                Text("Copy")
                    .font(.caption2)
                    .foregroundColor(Color.accentColor)
                    .opacity(isHovered ? 1 : 0)
                    .offset(x: isHovered ? 0 : -8)
            }
        }
        .buttonStyle(BorderlessButtonStyle())
        .contentShape(Rectangle())
        .onHover { hovering in
            self.isHovered = hovering
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.55), value: isHovered)
    }
}
