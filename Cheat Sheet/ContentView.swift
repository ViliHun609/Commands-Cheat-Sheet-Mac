import SwiftUI

struct ContentView: View {
    @StateObject private var categoryManager = CategoryManager()
    
    @State private var isQuitButtonHovered = false
    @State private var showCustomQuitPrompt = false
    @FocusState private var isCancelButtonFocused: Bool

    private var appVersionDisplay: String {
          if let version = Bundle.main.appVersion {
              return "v\(version)"
          } else {
              return "v?.?"
          }
      }

    var body: some View {
        VStack(spacing: 0) {
            // Header HStack
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
                        .foregroundColor(isQuitButtonHovered ? .red : .primary)
                        .scaleEffect(isQuitButtonHovered ? 1.25 : 1.0)
                        .animation(.spring(response: 0.35, dampingFraction: 0.5), value: isQuitButtonHovered)
                }
                .buttonStyle(PlainButtonStyle())
                .onHover { hovering in
                    self.isQuitButtonHovered = hovering
                }
                .padding(.trailing)
            }
            .frame(height: 30)
            .background(Color(NSColor.windowBackgroundColor))

            Divider()

            List {
                if categoryManager.filteredCategories.isEmpty {
                    Text("No categories enabled. Adjust in Settings.")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    ForEach(categoryManager.filteredCategories) { category in
                        NavigationLink(destination: CategoryItemsView(category: category)) {
                            CategoryRowView(category: category)
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .padding(.horizontal)

            // Settings Link HStack
            HStack() {
                NavigationLink(destination: SettingsView()) {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                Spacer()
            }
            .padding(.leading, 8)
            .padding(.bottom, 4)

        } // End of Main VStack
        .onAppear {
            // This ensures it runs every time the view appears.
            categoryManager.loadAndFilterCategories()
        }
        .overlay( // Overlay for Quit Prompt
            Group {
                if showCustomQuitPrompt {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                             self.showCustomQuitPrompt = false
                        }

                    VStack(spacing: 15) {
                        Image("G4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        
                        Text("Confirm Quit")
                            .font(.headline)
                            .allowsHitTesting(false)
                        
                        Text("Are you sure you want to close the app?")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .textSelection(.disabled)
                            .allowsHitTesting(false)

                        HStack(spacing: 20) {
                            Button("Cancel") {
                                self.showCustomQuitPrompt = false
                            }
                            .keyboardShortcut(.cancelAction)
                            .focused($isCancelButtonFocused)
                            .buttonStyle(PlainButtonStyle())

                            Button("Quit") {
                                NSApplication.shared.terminate(nil)
                            }
                            .keyboardShortcut(.defaultAction)
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.top, 10)
                    }
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                    .background(Material.regular)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                    .frame(width: 280)
                    .transition(.scale.combined(with: .opacity))
                }
            }
            .animation(.easeInOut, value: showCustomQuitPrompt)
        )
        .onChange(of: showCustomQuitPrompt) { oldValue, newValue in
            if newValue {
                DispatchQueue.main.async {
                    self.isCancelButtonFocused = true
                }
            }
        }
    } // End of var body
} // End of struct ContentView

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 380, height: 450)
    }
}
#endif

#Preview {
    ContentView()
}
