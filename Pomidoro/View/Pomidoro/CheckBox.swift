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
        Image(systemName: isComplete ? "checkmark.circle.fill" : "circle")
            .resizable()
            .scaledToFit()
            .foregroundColor(isComplete ? .green : .secondary)
            .frame(width: 25, height: 25)
    }
}

struct CheckBoxButton_Previews: PreviewProvider {
    static var previews: some View {
        CheckBox(isComplete: false)
    }
}
