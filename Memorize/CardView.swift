//
//  CardView.swift
//  Memorize
//
//  Created by Никита Аршинов on 1.05.25.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        TimelineView(.animation) { timeLine in
            if card.isFaceUp || !card.isMatched {
                Pie(endAngle: .degrees(card.bonucePercentRemaining * 360))
                    .opacity(0.4)
                    .overlay(cardContent.padding(2))
                    .padding(6)
                    .cardify(isFaceUp: card.isFaceUp)
                    .transition(.scale)
            } else {
                Color.clear
            }
        }
    }
    
    var cardContent: some View {
        Text(card.content)
            .font(.system(size: 200))
            .minimumScaleFactor(0.01)
            .aspectRatio(1, contentMode: .fit)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(duration: 2), value: card.isMatched)
    }
}

#Preview {
    typealias Card = MemoryGame<String>.Card
    return VStack {
        HStack {
            CardView(Card(isFaceUp: true, content: "🐻", id: "1"))
            CardView(Card(content: "🐻", id: "2"))
        }
        HStack {
            CardView(Card(isFaceUp: true, isMatched: true, content: "🐻", id: "1"))
            CardView(Card(isMatched: true, content: "🐻", id: "2"))
        }
    }
    .padding()
    .foregroundStyle(.orange)

    
}

extension Animation {
    static func spin(duration: CGFloat) -> Animation {
        .linear(duration: duration).repeatForever(autoreverses: false)
    }
}
