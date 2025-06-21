import SwiftUI

@main
struct Cheat_SheetApp: App {
    var body: some Scene {
        MenuBarExtra("Cheat Sheet", systemImage: "list.bullet.clipboard.fill") {
            NavigationStack {
                ContentView()
            }
            .frame(width: 380, height: 450)
        }
        .menuBarExtraStyle(.window)
    }
}
