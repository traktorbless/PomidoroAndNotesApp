//
//  PomidoroApp.swift
//  Pomidoro
//
//  Created by Антон Таранов on 28.03.2022.
//

import SwiftUI

@main
struct PomidoroApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
