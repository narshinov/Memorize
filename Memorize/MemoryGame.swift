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
    private(set) var score = 0
    
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
                        score += 2 + cards[choosenIndex].bonus + cards[potentialMatchIndex].bonus
                    } else {
                        if cards[choosenIndex].hasBeenSeen {
                            score -= 1
                        }
                        if cards[potentialMatchIndex].hasBeenSeen {
                            score -= 1
                        }
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
        
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    stratUsingBonusTime()
                } else {
                    stoppingUsingBonusTime()
                }
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        
        var isMatched = false {
            didSet {
                if isMatched {
                    stoppingUsingBonusTime()
                }
            }
        }
        var hasBeenSeen: Bool = false
        let content: CardContent
        
        var id: String
        
        private mutating func stratUsingBonusTime() {
            if isFaceUp && !isMatched && bonucePercentRemaining > 0, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stoppingUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
        
        var bonus: Int {
            Int(bonucePercentRemaining * bonusTimeLimit)
        }
        
        var bonucePercentRemaining: Double {
            bonusTimeLimit > 0 ? max(0, bonusTimeLimit - faceUpTime)/bonusTimeLimit : 0
        }
        
        var faceUpTime: TimeInterval {
            guard let lastFaceUpDate else {
                return pastFaceUpTime
            }
            return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
        }
        
        var bonusTimeLimit: TimeInterval = 6

        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0


    }
    
   
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
