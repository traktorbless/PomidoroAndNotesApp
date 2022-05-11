import SwiftUI
import CoreData

class PomidoroViewModel: ObservableObject {
    @Published var addTask = false
    @Published var showCompleteTask = false

    func addTask(name: String, numberOfPomidoro: Int, minuteOfPomidoro: Int, minuteOfPause: Int, moc: NSManagedObjectContext) {
        let task = Task(context: moc)
        task.id = UUID()
        task.name = name
        task.numberOfPomidoro = Int16(numberOfPomidoro)
        task.isComplete = false
        task.completeNumberOfPomidoro = 0
        task.minuteOfProgress = Int16(minuteOfPomidoro)
        task.secondOfProgress = 0
        task.taskMinuteOfPomidoro = Int16(minuteOfPomidoro)
        task.taskMinuteOfPause = Int16(minuteOfPause)
        task.statusOfTime = "Pomidoro"
        task.timeOfCloseTimer = nil
        task.statusOfButton = "Start"
        try? moc.save()
    }

    func deleteTask(at offsets: IndexSet, tasks: FetchedResults<Task>, moc: NSManagedObjectContext) {
        for offset in offsets {
            let task = tasks[offset]

            moc.delete(task)
        }

        try? moc.save()
    }
}
