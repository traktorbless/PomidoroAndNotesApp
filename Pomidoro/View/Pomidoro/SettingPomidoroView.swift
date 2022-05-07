//
//  SettingView.swift
//  Pomidoro
//
//  Created by Антон Таранов on 26.04.2022.
//

import SwiftUI

struct SettingPomidoroView: View {
    @EnvironmentObject var userSetting: UserSetting

    var body: some View {
        Form {
            Section {
                Picker("Time of Pomidoro", selection: $userSetting.setting.timeOfPomidoro) {
                    ForEach(1..<51) {
                        Text("\($0)")
                    }
                }
            } header: {
                Text("Time of Pomidoro")
            }

            Section {
                Picker("Time of Pause", selection: $userSetting.setting.timeOfPause) {
                    ForEach(1..<16) {
                        Text("\($0)")
                    }
                }
            } header: {
                Text("Time of Pause")
            }
        }
        .navigationTitle("Settings")
    }
}
