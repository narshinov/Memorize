//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Никита Аршинов on 3.05.25.
//

// MARK: ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    var cardsColor: Color = .randomColor()
    var themeTitle: String = ThemeType.animals.rawValue

    private static func createMemoryGame(theme: ThemeType = .animals) -> MemoryGame<String> {
        MemoryGame(numberOfPairOfCards: theme.emojis.count){ pairIndex in
            guard theme.emojis.indices.contains(pairIndex) else {
                return "⁉️"
            }
            return theme.emojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
        
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }

    var score: Int {
        model.score
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func newGame() {
        cardsColor = .randomColor()
        let theme = ThemeType.allCases.randomElement() ?? .animals
        themeTitle = theme.rawValue
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    func choosen(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
