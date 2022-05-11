import SwiftUI

struct PomidoroView: View {
    @ObservedObject var pomidoroApp: PomidoroViewModel

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    TaskList(pomidoroApp: pomidoroApp, showCompleteTask: pomidoroApp.showCompleteTask)
                        .listStyle(.plain)
                        .toolbar {
                            Button {
                                pomidoroApp.addTask = true
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.tomato)
                            }
                        }
                        .sheet(isPresented: $pomidoroApp.addTask) {
                            AddTaskView(pomidoroAddTask: pomidoroApp)
                        }

                    Button {
                        pomidoroApp.showCompleteTask.toggle()
                    } label: {
                        Text(pomidoroApp.showCompleteTask ? "Hide complete task" : "Show complete task")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.tomato)
                            .frame(width: 200, height: 44)
                            .cornerRadius(20)
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 20)
                                    .strokeBorder(.gray, lineWidth: 1)
                            })
                            .padding(.bottom)
                    }
                }
            }
            .navigationTitle("Pomidoro")
        }
    }
}
