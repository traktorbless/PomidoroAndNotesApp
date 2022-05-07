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

    let pomidoroApp = PomidoroViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(pomidoroApp: pomidoroApp)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
