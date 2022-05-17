import SwiftUI

struct TaskList: View {
    @FetchRequest var tasks: FetchedResults<Task>
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var pomidoroApp: PomidoroViewModel

    var body: some View {
        // MARK: List of tasks
        if !tasks.isEmpty {
            List {
                ForEach(tasks) { task in
                    TaskRow(task: task)
                }
                .onDelete(perform: { indexSet in
                    pomidoroApp.deleteTask(at: indexSet, tasks: tasks, moc: moc)
                })
                .listRowSeparator(.hidden)
            }
        } else {
            Text("List of tasks is empty")
                .font(.title)
                .foregroundColor(.secondary)
        }
    }

    init(pomidoroApp: PomidoroViewModel, showCompleteTask: Bool) {
        self.pomidoroApp = pomidoroApp
        let predicate = showCompleteTask ? nil : NSPredicate(format: "isComplete == false")
        _tasks = FetchRequest<Task>(sortDescriptors: [SortDescriptor(\.isComplete)], predicate: predicate)
    }
}
