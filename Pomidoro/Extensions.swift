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

struct RoundedRectangleBorder: ViewModifier {
    var style: Color
    var cornerRadius: Double
    var lineWidth: Double

    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(style, lineWidth: lineWidth)
            }
    }
}

extension View {
    func roundedRectangleBorder(style: Color, cornerRadius: Double, lineWidth: Double) -> some View {
        modifier(RoundedRectangleBorder(style: style, cornerRadius: cornerRadius, lineWidth: lineWidth))
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
