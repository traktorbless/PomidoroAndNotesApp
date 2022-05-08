//
//  TaskList.swift
//  Pomidoro
//
//  Created by Антон Таранов on 06.05.2022.
//

import SwiftUI

struct TaskList: View {
    @FetchRequest var tasks: FetchedResults<Task>
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var userSetting: UserSetting
    @ObservedObject var pomidoroApp: PomidoroViewModel

    var body: some View {
        if !tasks.isEmpty {
            List {
                ForEach(tasks) { task in
                    HStack {
                        TaskRow(task: task)
                            .environmentObject(userSetting)
                    }
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

    init(pomidoroApp: PomidoroViewModel, showCompleteTask: Bool, userSetting: UserSetting) {
        self.userSetting = userSetting
        self.pomidoroApp = pomidoroApp
        let predicate = showCompleteTask ? nil : NSPredicate(format: "isComplete == false")
        _tasks = FetchRequest<Task>(sortDescriptors: [SortDescriptor(\.isComplete)], predicate: predicate)
    }
}
