//
//  extensions.swift
//  Pomidoro
//
//  Created by Антон Таранов on 07.05.2022.
//

import Foundation
import SwiftUI

struct HideView: ViewModifier {
    var isHide: Bool

    func body(content: Content) -> some View {
        if isHide {
            content
                .hidden()
        } else {
            content
        }
    }
}

extension View {
    func hideView(isHide: Bool) -> some View {
        modifier(HideView(isHide: isHide))
    }
}

extension Color {
    public static let tomato: Color = Color(#colorLiteral(red: 1, green: 0.3280981183, blue: 0.2202442884, alpha: 1))
}

extension ShapeStyle where Self == Color {
    static var tomato: Color {
        Color(#colorLiteral(red: 1, green: 0.3280981183, blue: 0.2202442884, alpha: 1))
    }
}
