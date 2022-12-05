//
//  Styles.swift
//  demo
//
//  Created by User on 2022/11/20.
//

import SwiftUI

struct StrokeStyle: ViewModifier{
    var cornerRadius = 30.0
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .stroke(
                    .linearGradient(
                        colors: [
                            .white.opacity(colorScheme == .dark ? 0.6 : 0.3),
                            .black.opacity(colorScheme == .dark ? 0.3 : 0.1)
                        ], startPoint: .top, endPoint: .bottomTrailing
                    )
                )
                .blendMode(.overlay)
        )
    }
}

extension View{
    func strokStyle(cornerRadius: CGFloat = 30) -> some View{
        modifier(StrokeStyle(cornerRadius: cornerRadius))
    }
}
