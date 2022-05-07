//
//  TaskView.swift
//  Pomidoro
//
//  Created by Антон Таранов on 28.03.2022.
//

import SwiftUI

struct TaskView: View {
    @ObservedObject var task: Task
    @EnvironmentObject var userSettings: UserSetting
    @Environment(\.managedObjectContext) var moc
    @State private var status: StateOfButton
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
            .onReceive(time) { _ in
               computeTimer()
            }
            
            Button {
                status = status == .start ? .pause : .start
            } label: {
                Text(status == .start ? "Start" : "Pause")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(.tomato)
                    .cornerRadius(20)
                    .shadow(radius: 5)
            }
            
            Button {
                status = .start
                statusOfPomidoro = .pomidoro
                minute = userSettings.setting.timeOfPomidoro
                task.completeNumberOfPomidoro += 1
                if task.completeNumberOfPomidoro == task.numberOfPomidoro {
                    task.isComplete = true
                }
                try? moc.save()
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
    }
    
    init(timeOfPomidoro: Int, task: Task) {
        status = .start
        statusOfPomidoro = .pomidoro
        minute = timeOfPomidoro
        second = 0
        self.task = task
        progress = 0.0
        time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    enum StateOfButton {
        case pause
        case start
    }

    enum StateOfPomidoro {
        case pomidoro
        case pause
    }
    
    func computeTimer() {
        if status == .pause {
            if second == 0 {
                if minute == 0 {
                    status = .start
                    statusOfPomidoro = statusOfPomidoro == .pomidoro ? .pause : .pomidoro
                    if statusOfPomidoro == .pomidoro {
                        minute = userSettings.setting.timeOfPomidoro
                        task.completeNumberOfPomidoro += 1
                        if task.completeNumberOfPomidoro == task.numberOfPomidoro {
                            task.isComplete = true
                        }
                        try? moc.save()
                    } else {
                        minute = userSettings.setting.timeOfPause
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
            progress = 1.0 - Double(minute * 60 + second) / Double((statusOfPomidoro == .pomidoro ? userSettings.setting.timeOfPomidoro : userSettings.setting.timeOfPause) * 60)
        }
    }
    
}

