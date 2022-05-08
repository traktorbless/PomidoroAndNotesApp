//
//  ContentView.swift
//  Pomidoro
//
//  Created by Антон Таранов on 28.03.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var pomidoroApp: PomidoroViewModel
    @ObservedObject var notesApp: NotesViewModel

    var body: some View {
        TabView {
            PomidoroView(pomidoroApp: pomidoroApp)
                .tabItem {
                    VStack {
                        Image("tomato")
                            .padding(.bottom)

                        Text("Pomidoro")
                            .background(.red)
                            .foregroundColor(.red)
                    }
                }
            NotesView(notesApp: notesApp)
                .tabItem {
                    Label("Notes", systemImage: "note.text")
                }
        }
    }
}
