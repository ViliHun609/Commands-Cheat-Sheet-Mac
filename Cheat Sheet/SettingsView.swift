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
            
            Section("About") {
                HStack {
                    Text("App Version")
                    Spacer()
                    Text(appVersionDisplay)
                        .foregroundColor(.secondary)
                }
            }
            
            
        }
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
        print("[SettingsView Init] Category: '\(category.name)', Key: '\(fullKey)', Initial isEnabled from AppStorage: \(self.isEnabled)")
    }

    var body: some View {
        Toggle(category.name, isOn: $isEnabled)
            .onChange(of: isEnabled) { oldValue, newValue in
                let keyName = category.name.lowercased().replacingOccurrences(of: " ", with: "_")
                let fullKey = "category_enabled_\(keyName)"
                print("[SettingsView Change] Category: '\(category.name)', Key: '\(fullKey)', isEnabled toggled from \(oldValue) to -> \(newValue)")
                
                NotificationCenter.default.post(name: .categorySettingsChanged, object: nil)
                print("[SettingsView Change] Posted categorySettingsChanged notification.")
            }
    }
}

#Preview {
    NavigationView {
        SettingsView()
            .frame(width: 400, height: 400)
    }
}
