import SwiftUI

@main
struct PomidoroApp: App {
    @StateObject private var dataController = DataController()

    let pomidoroApp = PomidoroViewModel()
    let notesApp = NotesViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(pomidoroApp: pomidoroApp, notesApp: notesApp)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
