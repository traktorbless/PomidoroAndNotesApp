//
//  ContentView.swift
//  Pomidoro
//
//  Created by Антон Таранов on 28.03.2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            PomidoroView()
                .tabItem {
                    VStack {
                        Image("tomato")
                            .padding(.bottom)
                        
                        Text("Pomidoro")
                            .background(.red)
                            .foregroundColor(.red)
                    }
                }
            NotesView()
                .tabItem {
                    Label("Notes",systemImage: "note.text")
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
