//
//  CheckBoxButton.swift
//  Pomidoro
//
//  Created by Антон Таранов on 26.04.2022.
//

import SwiftUI

struct CheckBox: View {
    @State var isComplete: Bool
    
    var body: some View {
        if isComplete {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
        } else {
            Image(systemName: "circle")
                .foregroundColor(.secondary)
        }
    }
}

struct CheckBoxButton_Previews: PreviewProvider {
    static var previews: some View {
        CheckBox(isComplete: false)
    }
}
