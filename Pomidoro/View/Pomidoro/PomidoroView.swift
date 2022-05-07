//
//  PomidoroView.swift
//  Pomidoro
//
//  Created by Антон Таранов on 25.04.2022.
//

import SwiftUI

struct PomidoroView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var pomidoroApp: PomidoroViewModel
    @StateObject private var userSetting = UserSetting()

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    TaskList(showCompleteTask: pomidoroApp.showCompleteTask, userSetting: userSetting)
                        .listStyle(.plain)
                        .toolbar {
                            Button {
                                pomidoroApp.addTask = true
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.tomato)
                            }
                        }
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                NavigationLink {
                                    SettingPomidoroView()
                                        .environmentObject(userSetting)
                                }label: {
                                    Image(systemName: "gear")
                                        .foregroundColor(.tomato)
                                }
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
