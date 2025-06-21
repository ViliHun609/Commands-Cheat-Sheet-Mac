import SwiftUI

struct CheatSheetItem: Identifiable, Decodable {
    let id = UUID()
    var name: String
    var code: String
}
