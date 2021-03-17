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
    
    @ViewBuilder
    func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
                    .padding(5)
                    .opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }
    //        .modifier(Cardify(isFaceUp: card.isFaceUp))
//            Capsule().padding()
//            Text("HelloWorld")
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    //MARK: - Drawing Constants
    private let fontScaleFactor: CGFloat = 0.75
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
