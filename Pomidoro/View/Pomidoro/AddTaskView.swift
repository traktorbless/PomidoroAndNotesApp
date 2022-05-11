import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var numberOfPomidoro = 1
    @State private var timeOfPomidoro = 25
    @State private var timeOfPause = 5
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

                    Section {
                        Picker("Time of Pomidoro", selection: $timeOfPomidoro) {
                            ForEach(1..<51, id: \.self) {
                                Text("\($0)")
                            }
                        }
                    } header: {
                        Text("Time of Pomidoro")
                    }

                    Section {
                        Picker("Time of Pause", selection: $timeOfPause) {
                            ForEach(1..<16, id: \.self) {
                                Text("\($0)")
                            }
                        }
                    } header: {
                        Text("Time of Pause")
                    }

                    Button {
                        pomidoroAddTask.addTask(name: name, numberOfPomidoro: numberOfPomidoro, minuteOfPomidoro: timeOfPomidoro, minuteOfPause: timeOfPause, moc: moc)
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
