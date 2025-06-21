import Foundation

class DataService {
    static func loadCheatSheets() -> [CheatSheetCategory] {
        guard let url = Bundle.main.url(forResource: "cheat_sheets", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Error: Could not find or load cheat_sheets.json from bundle.")
            return []
        }

        do {
            let decoder = JSONDecoder()
            let categories = try decoder.decode([CheatSheetCategory].self, from: data)
            return categories
        } catch {
            print("Error: Could not decode cheat_sheets.json: \(error)")
            return []
        }
    }
}
