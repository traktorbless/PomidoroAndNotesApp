import SwiftUI

struct ContentView: View {
    @ObservedObject var pomidoroApp: PomidoroViewModel
    @ObservedObject var notesApp: NotesViewModel

    var body: some View {
        TabView {
            PomidoroView(pomidoroApp: pomidoroApp)
                .tag("Pomidoro")
                .tabItem {
                    Label("Pomidoro", image: "tomato")
                }
            NotesView(notesApp: notesApp)
                .tag("Notes")
                .tabItem {
                    Label("Notes", image: "notes")
                }
        }
        .hideView(isHide: pomidoroApp.hideTabItems)
    }
}
