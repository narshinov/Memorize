//
//  ContentView.swift
//  Memorize
//
//  Created by Никита Аршинов on 1.05.25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack {
            cards
                .animation(.default, value: viewModel.cards)
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
    }
    
    var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(2)
                .onTapGesture {
                    viewModel.choosen(card)
                }
        }
        .padding()
        .foregroundStyle(.orange)
    }
    


}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
