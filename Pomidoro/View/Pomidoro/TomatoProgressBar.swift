//
//  TomatoProgressBar.swift
//  Pomidoro
//
//  Created by Антон Таранов on 07.05.2022.
//

import SwiftUI

struct TomatoProgressBar: View {
    let completePomidoro: Int
    let countOfPomidoro: Int
    var body: some View {
        HStack {
            ForEach(1..<(countOfPomidoro + 1), id: \.self) {index in
                Image("tomato")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .opacity(index > completePomidoro ? 0.5 : 1)
            }
        }
    }
}

struct TomatoProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        TomatoProgressBar(completePomidoro: 3, countOfPomidoro: 4)
    }
}
