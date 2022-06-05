import SwiftUI
import UserNotifications
import CoreData

class PomidoroTaskViewModel: ObservableObject {
    @Published var statusOfButton: StateOfButton
    @Published var statusOfPomidoro: StateOfPomidoro
    @Published var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var minute: Int
    @Published var second: Int
    @Published var progress: Double

    var disableSkip: Bool {
        statusOfPomidoro == .pomidoro ? true : false
    }

    init(task: Task) {
        time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        statusOfButton = task.statusOfButton == "Start" ? .start : .pause
        statusOfPomidoro = task.wrappedStatusOfPomidoro == "Pomidoro" ? .pomidoro : .pause
        minute = Int(task.minuteOfProgress)
        second = Int(task.secondOfProgress)
        progress = task.progress
    }

    enum StateOfButton {
        case pause
        case start
    }

    enum StateOfPomidoro {
        case pomidoro
        case pause
    }

    func showNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        if statusOfButton == .pause {
            let content = UNMutableNotificationContent()
            content.title = statusOfPomidoro == .pomidoro ? "Work time has been ended" : "Break time has been ended"
            content.body = statusOfPomidoro == .pomidoro ? "Start your break" : "Continue your study"
            content.sound = UNNotificationSound.default

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(minute * 60 + second + 5), repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request)
            print("new notification")
        }
    }

    func computeTimer(task: Task, moc: NSManagedObjectContext) {
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
                    MusicPlayer.shared.playSoundEffect(soundEffect: "timeHasEnded")
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

    func skipPause(task: Task, moc: NSManagedObjectContext) {
        statusOfButton = .start
        statusOfPomidoro = .pomidoro
        minute = Int(task.taskMinuteOfPomidoro)
        task.completeNumberOfPomidoro += 1
        if task.completeNumberOfPomidoro == task.numberOfPomidoro {
            task.isComplete = true
        }
        try? moc.save()
    }

    func saveData(task: Task, moc: NSManagedObjectContext) {
        task.minuteOfProgress = Int16(minute)
        task.secondOfProgress = Int16(second)
        task.statusOfTime = statusOfPomidoro == .pomidoro ? "Pomidoro" : "Pause"
        task.timeOfCloseTimer = Date.now
        task.statusOfButton = statusOfButton == .start ? "Start" : "Pause"
        try? moc.save()
    }

    func loadData(task: Task) {
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
