import SwiftUI

struct NoHighlightNavigationLinkStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Color.clear)
            .foregroundColor(.primary)
    }
}

struct ContentView: View {
    @StateObject private var categoryManager = CategoryManager()
    
    @State private var isQuitButtonHovered = false
    @State private var showCustomQuitPrompt = false
    @FocusState private var isCancelButtonFocused: Bool
    @State private var isNavigating = false
    @State private var isHovered = false

    private var appVersionDisplay: String {
          if let version = Bundle.main.appVersion {
              return "v\(version)"
          } else {
              return "v?.?"
          }
      }

    var body: some View {
        VStack(spacing: 0) {
        
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
                
                VStack(alignment: .center, spacing: 0) {
                    NavigationLink(destination: SettingsView()) {
                        Label("", systemImage: "gearshape.fill")
                            .offset(y: isHovered ? -2 : -25)
                            .offset(x : 4)
                    }
                    .buttonStyle(.plain)
                    .onHover { hovering in
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.55)) {
                            self.isHovered = hovering
                        }
                    }                   
                }
                .frame(width: 28, height: 28)
                .background(
                    Image(systemName: "gear")
                        .opacity(isHovered ? 0 : 0.55)
                        .cornerRadius(10)
                )

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
            .background(Material.bar)
            
            
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
                        .buttonStyle(NoHighlightNavigationLinkStyle())
                        .listRowSeparator(.hidden)
                    }
                }
            }
            .scrollIndicators(.never)
            .listStyle(PlainListStyle())
            .padding(.horizontal, 8)
    
        }
        .background(Color.clear)
        .onAppear {
            categoryManager.loadAndFilterCategories()
        }
        .overlay(
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
                            .foregroundStyle(.red)
                            .keyboardShortcut(.defaultAction)
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.top, 10)
                    }
                    .frame(width: 150, height: 150)
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                    .background(Material.regular)
                    .cornerRadius(12)
                    .shadow(radius: 10)
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
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 300, height: 300)
            .background(Color.clear)
    }
}
#endif

#Preview {
    ContentView()
}
