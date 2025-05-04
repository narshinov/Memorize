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
        Pie(endAngle: .degrees(90))
            .opacity(0.4)
            .overlay {
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(2)
            }
            .padding(6)
            .cardify(isFaceUp: card.isFaceUp)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
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
