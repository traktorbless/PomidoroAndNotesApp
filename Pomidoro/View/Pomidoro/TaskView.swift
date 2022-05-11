import SwiftUI

struct TaskView: View {
    @ObservedObject var task: Task
    @Environment(\.managedObjectContext) var moc
    @State private var statusOfButton: StateOfButton
    @State private var statusOfPomidoro: StateOfPomidoro
    @State private var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var minute: Int
    @State private var second: Int
    @State private var progress: Double
    private var disableSkip: Bool {
        statusOfPomidoro == .pomidoro ? true : false
    }

    var body: some View {
        VStack {
            Text(task.wrappedName)
                .font(.largeTitle)

            Spacer()

            Text(statusOfPomidoro == .pomidoro ? "Work Time" : "Pause Time")
                .font(.title)
                .fontWeight(.bold)

            ProgressRing(progress: progress, minute: minute, second: second)

            Button {
                statusOfButton = statusOfButton == .start ? .pause : .start
            } label: {
                Text(statusOfButton == .start ? "Start" : "Pause")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(.tomato)
                    .cornerRadius(20)
                    .shadow(radius: 5)
            }

            Button {
                skipPause()
            } label: {
                Text("Skip")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.tomato)
                    .frame(width: 150, height: 44)
                    .background(.thickMaterial)
                    .cornerRadius(20)
                    .hideView(isHide: disableSkip)
            }
            .disabled(disableSkip)

            Spacer()
        }
        .onReceive(time) { _ in
           computeTimer()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            // MARK: Lock Screen
            saveData()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            // MARK: Unlock Screen
            loadData()
        }
        .onDisappear {
            saveData()
        }
        .onAppear {
            loadData()
        }
    }

    init(task: Task) {
        time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        statusOfButton = task.statusOfButton == "Start" ? .start : .pause
        statusOfPomidoro = task.wrappedStatusOfPomidoro == "Pomidoro" ? .pomidoro : .pause
        self.task = task
        minute = Int(task.minuteOfProgress)
        second = Int(task.secondOfProgress)
        progress = task.progress
    }

    private enum StateOfButton {
        case pause
        case start
    }

    private enum StateOfPomidoro {
        case pomidoro
        case pause
    }

    private func computeTimer() {
        if statusOfButton == .pause {
            if second == 0 {
                if minute == 0 {
                    statusOfButton = .start
                    if statusOfPomidoro == .pause {
                        statusOfPomidoro = .pomidoro
                        minute = Int(task.taskMinuteOfPomidoro)
                        task.completeNumberOfPomidoro += 1
                        if task.completeNumberOfPomidoro == task.numberOfPomidoro {
                            task.isComplete = true
                        }
                        try? moc.save()
                    } else {
                        statusOfPomidoro = .pause
                        minute = Int(task.taskMinuteOfPause)
                    }
                    withAnimation(.easeInOut) {
                        progress = 0
                    }
                } else {
                    minute -= 1
                    second = 59
                }
            } else {
                second -= 1
            }
            progress = 1.0 - Double(minute * 60 + second) / Double((statusOfPomidoro == .pomidoro ? task.taskMinuteOfPomidoro : task.taskMinuteOfPause) * 60)
        }
    }

    private func skipPause() {
        statusOfButton = .start
        statusOfPomidoro = .pomidoro
        minute = Int(task.taskMinuteOfPomidoro)
        task.completeNumberOfPomidoro += 1
        if task.completeNumberOfPomidoro == task.numberOfPomidoro {
            task.isComplete = true
        }
        try? moc.save()
    }

    private func saveData() {
        task.minuteOfProgress = Int16(minute)
        task.secondOfProgress = Int16(second)
        task.statusOfTime = statusOfPomidoro == .pomidoro ? "Pomidoro" : "Pause"
        task.timeOfCloseTimer = Date.now
        task.statusOfButton = statusOfButton == .start ? "Start" : "Pause"
        try? moc.save()
    }

    private func loadData() {
        if statusOfButton == .pause {
            if let timeOfClosingTimer = task.timeOfCloseTimer {
                let timeInterval = Date.now.timeIntervalSince(timeOfClosingTimer)
                if minute * 60 + second - Int(timeInterval) < 0 {
                    progress = 0.0
                    second = 0
                    if statusOfPomidoro == .pomidoro {
                        statusOfPomidoro = .pause
                        minute = Int(task.taskMinuteOfPause)
                    } else {
                        statusOfPomidoro = .pomidoro
                        task.completeNumberOfPomidoro += 1
                        if task.completeNumberOfPomidoro == task.numberOfPomidoro {
                            task.isComplete = true
                        }
                        minute = Int(task.taskMinuteOfPomidoro)
                    }
                    statusOfButton = .start
                } else {
                    minute -= Int(timeInterval) / 60
                    second -= Int(timeInterval) % 60
                    if second < 0 {
                        second = 60 + second
                    }
                    progress = 1 - Double(minute * 60 + second) / Double(task.taskMinuteOfPomidoro * 60)
                }
            }
        }
    }
}
