//
//  TaskRow.swift
//  Pomidoro
//
//  Created by Антон Таранов on 28.03.2022.
//

import SwiftUI

struct TaskRow: View {
    @ObservedObject var task: Task
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var userSetting: UserSetting

    var body: some View {
            HStack {
                CheckBox(isComplete: task.isComplete)
                    .onTapGesture {
                        task.isComplete = true
                        try? moc.save()
                    }
                    .padding(.trailing)

                VStack(alignment: .leading, spacing: 0) {
                    Text(task.wrappedName)
                        .font(.title2)
                        .padding(.top)

                    TomatoProgressBar(completePomidoro: Int(task.completeNumberOfPomidoro), countOfPomidoro: Int(task.numberOfPomidoro))
                        .padding(.bottom)
                }

                Spacer()

                NavigationLink {
                    TaskView(timeOfPomidoro: userSetting.setting.timeOfPomidoro, task: task)
                        .environmentObject(userSetting)
                } label: {
                    EmptyView()
                }
            }
            .roundedRectangleBorder(style: .tomato, cornerRadius: GeometryValue.cornerRadius, lineWidth: GeometryValue.lineWidth)
        }

    struct GeometryValue {
        static var cornerRadius = 15.0
        static var lineWidth = 2.0
    }
}
