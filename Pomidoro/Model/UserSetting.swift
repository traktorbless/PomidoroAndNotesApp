//
//  File.swift
//  Pomidoro
//
//  Created by Антон Таранов on 28.04.2022.
//

import Foundation

class UserSetting: ObservableObject {
    @Published var setting: Setting {
        didSet {
            if let encode = try? JSONEncoder().encode(setting) {
                UserDefaults.standard.set(encode, forKey: "Setting")
            }
        }
    }
    
    init() {
        if let saveData = UserDefaults.standard.data(forKey: "Setting") {
            if let decoder = try? JSONDecoder().decode(Setting.self, from: saveData) {
                setting = decoder
                return 
            }
        }
        setting = Setting(timeOfPomidoro: 25, timeOfPause: 5)
    }
}

struct Setting: Codable {
    var timeOfPomidoro: Int
    var timeOfPause: Int
}
