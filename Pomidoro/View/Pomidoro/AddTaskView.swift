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
    @ObservedObject var pomidoroAddTask: PomidoroViewModel

    @Environment(\.managedObjectContext) var moc

    private var disableAddButton: Bool {
        name.isEmpty ? true : false
    }

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section("Name") {
                        TextField("Name", text: $name)
                    }

                    Section("Pomidoros") {
                        Picker("Pomidoros", selection: $numberOfPomidoro) {
                            ForEach(1..<6, id: \.self) {
                                Text("\($0)")
                            }
                        }
                    }

                    Button {
                        pomidoroAddTask.addTask(name: name, numberOfPomidoro: numberOfPomidoro, moc: moc)
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
