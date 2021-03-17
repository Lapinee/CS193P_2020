//
//  MemoryGame.swift
//  Memorize
//
//  Created by Azuchan on 2021/03/15.
//

import Foundation
//Model

//Equal에 대한 Operand가 Language에 기본으로 들어 있지 않으므로, Equatable 프로토콜 타입으로 설정
//Equatable에 대한 필수 함수를 구현해줘야 함
struct MemoryGame<CardContent> where CardContent: Equatable{
    //read-only
    private(set) var cards: Array<Card>
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        //collectionType - indices: Array 범위 내에서 안전하게 조회
        get { cards.indices.filter { cards[$0].isFaceUp }.only } //Closure and extension
        set {
            for index in cards.indices {
                    cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    //구조체 내의 Array 데이터 속성의 변경을 위해 mutating키워드를 붙여준다. 속성 변경 시점을 알기 위함
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard { //get
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
            }
            else
            {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex //set
            }
            self.cards[chosenIndex].isFaceUp = true
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id:pairIndex*2))
            cards.append(Card(content: content, id:pairIndex*2+1))
        }
        //Shuffle cards Array
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent //Equatable extension
        var id: Int //Identifiable attribute
    }
}
