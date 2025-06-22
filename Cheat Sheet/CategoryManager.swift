import SwiftUI
import Combine

extension Notification.Name {
    static let categorySettingsChanged = Notification.Name("categorySettingsChanged")
}

class CategoryManager: ObservableObject {
    @Published var filteredCategories: [CheatSheetCategory] = []
    private var settingsChangedCancellable: AnyCancellable?

    init() {
        loadAndFilterCategories() 

        settingsChangedCancellable = NotificationCenter.default
            .publisher(for: .categorySettingsChanged)
            .sink { [weak self] _ in
                print("[CategoryManager] Received categorySettingsChanged notification. Reloading categories.")
                self?.loadAndFilterCategories()
            }
    }

    deinit {
        settingsChangedCancellable?.cancel()
        print("[CategoryManager] Deinitialized and notification observer cancelled.")
    }

    func loadAndFilterCategories() {
        let allCategories = DataService.loadCheatSheets()
        print("[CategoryManager loadAndFilterCategories] START: Loaded \(allCategories.count) categories from DataService.")
        
        self.filteredCategories = allCategories.filter { category in
            let keyName = category.name.lowercased().replacingOccurrences(of: " ", with: "_")
            let key = "category_enabled_\(keyName)"
            
            let rawValueFromUserDefaults = UserDefaults.standard.object(forKey: key)
            let decisionToShowCategory = UserDefaults.standard.object(forKey: key) as? Bool ?? true
            
            print("[CategoryManager loadAndFilterCategories] Filtering Category: '\(category.name)'")
            print("  - Key being used: '\(key)'")
            print("  - Raw value from UserDefaults.standard.object(forKey: key): \(String(describing: rawValueFromUserDefaults))")
            print("  - Decision (rawValue as? Bool ?? true): \(decisionToShowCategory)")
            
            return decisionToShowCategory
        }
        print("[CategoryManager loadAndFilterCategories] END: Filtered list contains \(self.filteredCategories.count) categories.")
    }
}
