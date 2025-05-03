//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Никита Аршинов on 3.05.25.
//

// MARK: ViewModel

import SwiftUI

//["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🎱"]
//["🚗", "🚕", "🚑", "🚎", "🚒", "🚓", "🚜", "🛵"]

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["🐶", "🐭", "🐨", "🐵", "🐷", "🐮", "🐼", "🐸", "🦁"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairOfCards: 8){ pairIndex in
            guard emojis.indices.contains(pairIndex) else {
                return "⁉️"
            }
            return emojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choosen(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    
}
