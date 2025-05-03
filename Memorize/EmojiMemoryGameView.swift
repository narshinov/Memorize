//
//  ContentView.swift
//  Memorize
//
//  Created by Никита Аршинов on 1.05.25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        NavigationStack {
            ScrollView {
                cards.animation(.default, value: viewModel.cards)
            }
            .navigationTitle(viewModel.themeTitle)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Score: \(viewModel.score)")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.newGame()
                    } label: {
                        Image(systemName: "arrow.trianglehead.clockwise.rotate.90")
                    }
                }
            }
        }
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(2)
                    .onTapGesture {
                        viewModel.choosen(card)
                    }
            }
            .foregroundStyle(viewModel.cardsColor)
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
