//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Azuchan on 2021/03/15.
//

import SwiftUI
//ViewModel

class EmojiMemoryGame:ObservableObject {
    //model에 대한 접근은 ViewModel에서만 가능하도록 private 설정
    //ObservableObject프로토콜 시, 객체 변화했을 때 objectWillChange.send()가 호출되어야 하나 인텐트가 많을 경우
    //일일이 처리하기 힘드므로, @Published 프로퍼티 래퍼를 설정해주면 objectWillChange.send()를 호출하지 않아도 model
    //이 변화할 때마다 objectWillChange.send()가 호출된다.
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    //viewModel 생성 후 초기화 되어야만 이용이 가능하므로, 정적함수로 선언
    static func createMemoryGame() -> MemoryGame<String> { //초기화
        let emojis: Array<String> = ["👻", "🎃", "🕷", "🍒"]
        return MemoryGame<String>(numberOfPairsOfCards:emojis.count) { pairIndex in //Closure
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the model
    var cards:Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    //View로부터 동작 실행에 대한 Intent
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
