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
