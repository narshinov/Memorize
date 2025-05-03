//
//  MemoryGame.swift
//  Memorize
//
//  Created by Никита Аршинов on 3.05.25.
//

import Foundation

// MARK: Model

struct MemoryGame <CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    var score: Int = .zero
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {cards.indices.filter {cards[$0].isFaceUp }.only}
        set {cards.indices.forEach {cards[$0].isFaceUp = (newValue == $0)}}
    }
    
    init(numberOfPairOfCards: Int, myCardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        
        for pairIndex in 0..<max(2,numberOfPairOfCards) {
            let cardContent: CardContent = myCardContentFactory(pairIndex)
            cards.append(Card(content: cardContent, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: cardContent, id: "\(pairIndex + 1)b"))
        }
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        if let choosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if !cards[choosenIndex].isFaceUp && !cards[choosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[choosenIndex].content == cards[potentialMatchIndex].content {
                        cards[choosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    } else {
                        score -= 1
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = choosenIndex
                    
                }
                cards[choosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable {
        static func == (lhs: Card, rhs: Card) -> Bool {
            lhs.content == rhs.content &&
            lhs.isMatched == rhs.isMatched &&
            lhs.isFaceUp == rhs.isFaceUp
        }
        
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
        var id: String
    }
}
