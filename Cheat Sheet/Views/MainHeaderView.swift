import SwiftUI

struct MainHeaderView: View {
    
    @StateObject private var categoryManager = CategoryManager()
    
    @State private var isQuitButtonHovered = false
    @State private var showCustomQuitPrompt = false
    @FocusState private var isCancelButtonFocused: Bool
    @State private var isHovered = false
    
    private var appVersionDisplay: String {
          if let version = Bundle.main.appVersion {
              return "v\(version)"
          } else {
              return "v?.?"
          }
      }
    
    
    var body: some View {
        HStack {
            Image("G4")
                .resizable()
                .scaledToFit()
                .frame(width: 23, height: 24)
                .padding(.leading, 12)

            Text(appVersionDisplay)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.leading, 8)

            Spacer()

            Text("Cheat Sheets")
                .font(.headline)

            Spacer()
            Spacer()

            Button(action: {
                self.showCustomQuitPrompt = true
            }) {
                Label("Quit", systemImage: "xmark.circle.fill")
                    .labelStyle(.iconOnly)
                    .opacity(isQuitButtonHovered ? 1 : 0)
                    .offset(x: isQuitButtonHovered ? 0 : 35)
                    .foregroundColor(isQuitButtonHovered ? .red : .primary)
                    .scaleEffect(isQuitButtonHovered ? 1.25 : 1.0)
                    .animation(.spring(response: 0.35, dampingFraction: 0.75), value: isQuitButtonHovered)
            }
            .buttonStyle(PlainButtonStyle())
            .background(
                Color.red
                    .opacity(0.1)
            )
                .cornerRadius(10)
            .onHover { hovering in
                self.isQuitButtonHovered = hovering
            }
            .padding(.trailing)
            
        }
        .frame(height: 30)
        .background(Color(NSColor.windowBackgroundColor))
        
    }
}

#Preview {
    MainHeaderView()
}
