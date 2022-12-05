//
//  AnimatableFontModifier.swift
//  demo
//
//  Created by User on 2022/11/26.
//

import SwiftUI

struct AnimatableFontModifier: AnimatableModifier {
    var size: Double
    var weight: Font.Weight = .regular
    var design: Font.Design = .default
    var animatableData: Double{
        get {size}
        set {size = newValue}
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight, design: design))
    }
}

//直接用上面的类太麻烦，增加view func 更方便
extension View{
    func animatableFont(size: Double, weight: Font.Weight = .regular, design: Font.Design = .default) -> some View{
        self.modifier(AnimatableFontModifier(size: size, weight: weight, design: design))
    }
}
