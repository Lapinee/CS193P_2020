//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Azuchan on 2021/03/11.
//

import SwiftUI
//View

struct EmojiMemoryGameView: View {
    //View는 ViewModel의 Pointer를 가지고 있음, viewModel 지정
    //@ObservedObject 프로퍼티 래퍼는 objectWillChange.send()가 호출되면 뷰를 다시 그림
    @ObservedObject var viewModel:EmojiMemoryGame //viewModel 생성
    
    var body: some View {
        //View Builder
        Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture { //Closure
                    self.viewModel.choose(card: card)
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card //accessing to Model
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
                
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    //MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.75
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
