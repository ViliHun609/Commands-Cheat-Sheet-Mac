import SwiftUI

@main
struct Cheat_SheetApp: App {
    var body: some Scene {
        MenuBarExtra("Cheat Sheet", systemImage: "list.bullet.clipboard.fill") {
            NavigationStack {
                ContentView()
            }
            .frame(minWidth: 250, minHeight: 300)
            .background(.clear)
            
        }
        .menuBarExtraStyle(.window)
    }
}
