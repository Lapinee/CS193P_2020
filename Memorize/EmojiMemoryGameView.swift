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
    var viewModel:EmojiMemoryGame //viewModel 생성
    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture { //Closure
                    self.viewModel.choose(card: card)
                }
            }
        }
            .padding()
            .foregroundColor(Color.orange)
            .font(Font.largeTitle)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card //accessing to Model
    
    var body: some View {
        
        ZStack {
            if card.isFaceUp { 
            RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
            RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
