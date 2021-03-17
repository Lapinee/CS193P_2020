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
struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            } else {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    
}
