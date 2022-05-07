//
//  PomidoroViewModel.swift
//  Pomidoro
//
//  Created by Антон Таранов on 07.05.2022.
//

import SwiftUI
import CoreData

class PomidoroViewModel: ObservableObject {
    @Published var addTask = false
    @Published var showCompleteTask = false

    func addTask(name: String, numberOfPomidoro: Int, moc: NSManagedObjectContext) {
        let task = Task(context: moc)
        task.id = UUID()
        task.name = name
        task.numberOfPomidoro = Int32(numberOfPomidoro)
        task.isComplete = false
        task.completeNumberOfPomidoro = 0
        try? moc.save()
    }
}
