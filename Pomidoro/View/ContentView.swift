import SwiftUI

struct ContentView: View {
    @ObservedObject var pomidoroApp: PomidoroViewModel
    @ObservedObject var notesApp: NotesViewModel

    var body: some View {
        TabView {
            PomidoroView(pomidoroApp: pomidoroApp)
                .tabItem {
                    Label("Pomidoro", image: "tomato")
                }
            NotesView(notesApp: notesApp)
                .tabItem {
                    Label("Notes", image: "notes")
                }
        }
    }
}
