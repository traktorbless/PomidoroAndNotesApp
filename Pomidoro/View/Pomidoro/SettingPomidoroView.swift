//
//  SettingView.swift
//  Pomidoro
//
//  Created by Антон Таранов on 26.04.2022.
//

import SwiftUI

struct SettingPomidoroView: View {
    private let timesOfPomidoro = [25,30,40,50]
    private let timesOfPause = [5,10,15]
    @EnvironmentObject var userSetting: UserSetting
    
    var body: some View {
        Form {
            Section {
                Picker("Time of Pomidoro", selection: $userSetting.setting.timeOfPomidoro) {
                    ForEach(1..<51, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.automatic)
            } header: {
                Text("Time of Pomidoro")
            }
            
            Section {
                Picker("Time of Pause", selection: $userSetting.setting.timeOfPause) {
                    ForEach(timesOfPause, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.segmented)
            } header: {
                Text("Time of Pause")
            }
        }
        .navigationTitle("Settings")
    }
}
