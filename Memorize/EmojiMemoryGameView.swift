//
//  ContentView.swift
//  Memorize
//
//  Created by Никита Аршинов on 1.05.25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @Namespace private var dealingNamespace
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel: EmojiMemoryGame
    
    @State private var lastScoreChange = (0, causedByCardId: "")
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack {
            cards
                .foregroundStyle(.orange)
            HStack {
                score
                Spacer()
                deck
                    .foregroundStyle(.orange)
                Spacer()
                shuffle
            }
            .font(.title)
        }
        .padding()

    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(2)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card: card)
                    }
                    .transition(.offset(
                        x: .random(in: -1000...1000),
                        y: .random(in: -1000...1000)
                    ))
            }
        }
    }
    
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) {
                CardView($0)
                    .matchedGeometryEffect(id: $0.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: 50, height: 50 / aspectRatio)
        .onTapGesture {
            deal()
        }
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }

    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }
    }

    private func scoreChange(causedBy card: Card) -> Int {
        let (amout, id) = lastScoreChange
        return card.id == id ? amout : 0
    }
    
    private func choose(card: Card) {
        withAnimation {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choosen(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    
    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(.easeInOut(duration: 0.5).delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += 0.15
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
