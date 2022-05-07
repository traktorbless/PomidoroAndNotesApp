//
//  DataController.swift
//  Pomidoro
//
//  Created by Антон Таранов on 26.04.2022.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "PomidoroAppData")
    init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data failed to load \(error.localizedDescription)")
            }
        }
    }
}
