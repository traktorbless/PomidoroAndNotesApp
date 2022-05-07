//
//  AddTaskView.swift
//  Pomidoro
//
//  Created by Антон Таранов on 28.03.2022.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var numberOfPomidoro = 1
    
    @Environment(\.managedObjectContext) var moc
    
    private var disableAddButton: Bool {
        name.isEmpty ? true : false
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section("Name") {
                        TextField("Name",text: $name)
                    }
                    
                    Section("Pomidoros") {
                        Picker("Pomidoros", selection: $numberOfPomidoro) {
                            ForEach(1..<6, id: \.self) {
                                Text("\($0)")
                            }
                        }
                    }
                    
                    Button {
                        let task = Task(context: moc)
                        task.id = UUID()
                        task.name = name
                        task.numberOfPomidoro = Int32(numberOfPomidoro)
                        task.isComplete = false
                        task.completeNumberOfPomidoro = 0
                        try? moc.save() // Handle error here
                        dismiss()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Add")
                            Spacer()
                        }
                    }
                    .disabled(disableAddButton)
                }
            }
            .navigationTitle("New Task")
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
