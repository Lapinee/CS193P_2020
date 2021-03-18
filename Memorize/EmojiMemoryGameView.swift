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
                    withAnimation(.linear(duration:0.75)) {
                        self.viewModel.choose(card: card)
                    }
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(Color.orange)
        Button(action: {
            withAnimation (.easeInOut) {
                    self.viewModel.resetGame()
                }
            }, label: {
            Text("새로운 게임") })
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card //accessing to Model
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaing
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    //some View를 return하는 경우, @ViewBuilder 키워드를 넣을 수 있음
    //Content는 ViewList로 해석하고 하나로 결합
    @ViewBuilder
    func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                            .onAppear {
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaing*360-90), clockwise: true)
                    }
                }
                .padding(5)
                .opacity(0.4)
                .transition(.identity)

                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 :0))
                    .animation(card.isMatched ? Animation.linear(duration: 1) .repeatForever(autoreverses: false) : .default)
            }
    //        .modifier(Cardify(isFaceUp: card.isFaceUp))
//            Capsule().padding()
//            Text("HelloWorld")
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
        
    }
    
    //MARK: - Drawing Constants
    private let fontScaleFactor: CGFloat = 0.75
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

//아래와 같이 구현할 경우,  어떤 View에서도 사용이 가능
//View에 modifier 추가
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
