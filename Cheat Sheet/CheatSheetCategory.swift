import SwiftUI

struct CheatSheetCategory: Identifiable, Decodable {
    let id = UUID()
    var name: String
    var systemImageName: String
    var subtitle: String
    var items: [CheatSheetItem]
}
