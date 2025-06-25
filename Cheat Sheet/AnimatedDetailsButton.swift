import SwiftUI

struct AnimatedDetailsButton: View {
    
    let item: CheatSheetItem
    @State private var isHovered = false
    @State private var isNavigating = false
    
    var body: some View {
        
        Button {
            isNavigating = true
        } label: {
            VStack(spacing: 2) {
                
                Image(systemName: "questionmark.folder")
                .foregroundColor(isHovered ? Color.accentColor : Color.secondary)
                .scaleEffect(isHovered ? 1.15 : 1.0)
                .offset(y: isHovered ? 0 : 8)
                                
                Text("Details")
                        .font(.caption2)
                        .foregroundColor(Color.accentColor)
                        .opacity(isHovered ? 1 : 0)
                        .offset(y: isHovered ? 0: -8)
                        .fixedSize()
            }

        }
        .frame(maxWidth: 25, maxHeight: 40)
        .buttonStyle(PlainButtonStyle())
        .contentShape(Rectangle())
        .onHover { hovering in
            withAnimation(.spring(response: 0.3, dampingFraction: 0.55)) {
                self.isHovered = hovering
            }
        }
        .background(
            NavigationLink("", destination: CheatSheetDetailView(item: item), isActive: $isNavigating)
                .opacity(0)
        )
        
    }
}

#Preview {
    
    Group {
        AnimatedDetailsButton(item: CheatSheetItem(name: "Sample Command", code: "sample code here"))
        .padding()
        .frame(maxWidth: 200, maxHeight: 100)
        
        
     
        
    }
}
