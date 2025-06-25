import SwiftUI

struct SettingsView: View {
    @State private var allCategories: [CheatSheetCategory] = []

    private var appVersionDisplay: String {
        if let version = Bundle.main.appVersion {
            return "v\(version)"
        } else {
            return "v?.?"
        }
    }

    var body: some View {        
        Form {
            Section("Display Categories") {
                if allCategories.isEmpty {
                    Text("Loading categories...")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(allCategories) { category in
                        CategoryToggleRow(category: category)
                    }
                }
            }

            

            Spacer()
            Spacer()

            Section("About") {
                HStack {
                    Text("App Version")
                    Spacer()
                    Text(appVersionDisplay)
                        .foregroundColor(.secondary)
                }
            }
        }
        .frame(height: 200)
        .padding(.top, 0)
        .padding()
        .navigationTitle("Settings")
        .navigationSubtitle(appVersionDisplay)
        .onAppear {
            self.allCategories = DataService.loadCheatSheets()
        }
    }
}

struct CategoryToggleRow: View {
    let category: CheatSheetCategory
    @AppStorage var isEnabled: Bool

    init(category: CheatSheetCategory) {
        self.category = category
        let keyName = category.name.lowercased().replacingOccurrences(of: " ", with: "_")
        let fullKey = "category_enabled_\(keyName)"
        _isEnabled = AppStorage(wrappedValue: true, fullKey)
    }

    var body: some View {
        
        Toggle(category.name, isOn: $isEnabled)
            .onChange(of: isEnabled) { oldValue, newValue in
                NotificationCenter.default.post(name: .categorySettingsChanged, object: nil)
            }
    }
}

#Preview {
    SettingsView()
        .frame(width: 300, height: 300)
        .background(.clear)
}
