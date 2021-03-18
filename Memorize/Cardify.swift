//
//  Cardify.swift
//  Memorize
//
//  Created by Azuchan on 2021/03/17.
//

import SwiftUI

//ViewModifier 프로토콜은 전달된 항목을 기반으로 새로운 View를 생성
//aspectRatio, Padding
//protocol ViewModifier {
//  func body(content: Content) -> some View {
//          return some View that represents a modification of content
//      }
//  }
struct Cardify: AnimatableModifier {//ViewModifier, Animatable {
    var rotation: Double
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }
                .opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: cornerRadius).fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    
}
