//
//  MemoryGame.swift
//  Memorize
//
//  Created by Никита Аршинов on 3.05.25.
//

import Foundation

// MARK: Model

struct MemoryGame <CardContent> {
    private(set) var cards: [Card]
    
    init(numberOfPairOfCards: Int, myCardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        
        for pairIndex in 0..<max(2,numberOfPairOfCards) {
            let cardContent: CardContent = myCardContentFactory(pairIndex)
            cards.append(Card(content: cardContent))
            cards.append(Card(content: cardContent))
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        
    }
}
