//
//  PomidoroView.swift
//  Pomidoro
//
//  Created by Антон Таранов on 25.04.2022.
//

import SwiftUI

struct PomidoroView: View {
    @State var addTask = false
    @Environment(\.managedObjectContext) var moc
    @StateObject private var userSetting = UserSetting()
    @State private var showCompleteTask = false
    @StateObject var pomidoroApp = PomidoroViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    TaskList(showCompleteTask: showCompleteTask, userSetting: userSetting)
                        .listStyle(.plain)
                        .toolbar {
                            Button {
                                addTask = true
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
                        .sheet(isPresented: $addTask) {
                            AddTaskView()
                        }
                    
                    Button {
                        showCompleteTask.toggle()
                    } label: {
                        Text(showCompleteTask ? "Hide complete task" : "Show complete task")
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

struct PomidoroView_Previews: PreviewProvider {
    static var previews: some View {
        PomidoroView()
    }
}
