//
//  ProgressRing.swift
//  Pomidoro
//
//  Created by Антон Таранов on 04.05.2022.
//

import SwiftUI

struct ProgressRing: View {
    let progress: Double
    let minute: Int
    let second: Int
    var formatTime: String {
        let formatMinute = minute > 9 ? "\(minute)" : "0\(minute)"
        let formatSecond = second > 9 ? "\(second)" : "0\(second)"
        return formatMinute + ":" + formatSecond
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(.gray)
                .opacity(0.1)
            
            Circle()
                .trim(from: 0.0, to: min(progress,1.0))
                .stroke(.tomato, lineWidth: 20)
                .rotationEffect(Angle(degrees: 270))
                .animation(.linear(duration: 1.0), value: progress)
            
            VStack(spacing: 30) {
                VStack(spacing: 5) {
                    Text("Remaining time")
                        .opacity(0.7)
                    
                    Text(formatTime)
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
        }
        .frame(width: 250, height: 250)
        .padding()
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRing(progress: 0.5, minute: 25, second: 34)
    }
}
