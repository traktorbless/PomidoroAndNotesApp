import SwiftUI

struct TaskView: View {
    @ObservedObject var task: Task
    @Environment(\.managedObjectContext) var moc
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var taskViewModel: PomidoroTaskViewModel

    var body: some View {
        VStack {
            Text(task.wrappedName)
                .font(.largeTitle)

            Spacer()

            Text(taskViewModel.statusOfPomidoro == .pomidoro ? "Work Time" : "Pause Time")
                .font(.title)
                .fontWeight(.bold)

            ProgressRing(progress: taskViewModel.progress, minute: taskViewModel.minute, second: taskViewModel.second)

            Button {
                taskViewModel.statusOfButton = taskViewModel.statusOfButton == .start ? .pause : .start
            } label: {
                Text(taskViewModel.statusOfButton == .start ? "Start" : "Pause")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(.tomato)
                    .cornerRadius(20)
                    .shadow(radius: 5)
            }

            Button {
                taskViewModel.skipPause(task: task, moc: moc)
            } label: {
                Text("Skip")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.tomato)
                    .frame(width: 150, height: 44)
                    .background(.thickMaterial)
                    .cornerRadius(20)
                    .hideView(isHide: taskViewModel.disableSkip)
            }
            .disabled(taskViewModel.disableSkip)

            Spacer()
        }
        .onChange(of: scenePhase, perform: { newPhase in
            if newPhase == .active {
                taskViewModel.loadData(task: task)
            } else if newPhase == .background {
                taskViewModel.showNotification()
                taskViewModel.saveData(task: task, moc: moc)
            }
        })
        .onReceive(taskViewModel.time) { _ in
            taskViewModel.computeTimer(task: task, moc: moc)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { _ in
            // MARK: Close App
            taskViewModel.saveData(task: task, moc: moc)
            task.statusOfButton = "Start"
            try? moc.save()
            print("Close App")
        }
        .onDisappear {
            taskViewModel.saveData(task: task, moc: moc)
            task.statusOfButton = "Start"
            try? moc.save()
            print("Disappear task view")
        }
        .onAppear {
            taskViewModel.loadData(task: task)
            print("Appear task view")
        }
    }

    init(task: Task) {
        self.task = task
        taskViewModel = PomidoroTaskViewModel(task: task)
    }
}
