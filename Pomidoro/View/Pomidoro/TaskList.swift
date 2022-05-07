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
    
    var body: some View {
            List {
                ForEach(tasks) { task in
                    HStack {
                        TaskRow(task: task)
                            .environmentObject(userSetting)
                    }
                }
                .onDelete(perform: deleteTask)
                .listRowSeparator(.hidden)
        }
    }
        
    func deleteTask(at offsets: IndexSet) {
        for offset in offsets {
            let task = tasks[offset]
            
            moc.delete(task)
        }
        
        try? moc.save()
    }
    
    init(showCompleteTask: Bool, userSetting: UserSetting) {
        self.userSetting = userSetting
        let predicate = showCompleteTask ? nil : NSPredicate(format: "isComplete == false")
        _tasks = FetchRequest<Task>(sortDescriptors: [SortDescriptor(\.isComplete)], predicate: predicate)
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList(showCompleteTask: true ,userSetting: UserSetting())
    }
}
