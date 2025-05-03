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
        VStack {
            ScrollView {
                cards
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        
    }
    
    var cards: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0
        ) {
            ForEach(viewModel.cards.indices, id: \.self) {
                CardView(viewModel.cards[$0])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(2)
            }
        }
    }
    
    var themes: some View {
        HStack(spacing: 32) {
            let thems = ThemeType.allCases
            ForEach(0..<3, id: \.self) {
                themeCoosing(with: thems[$0])
            }
        }
    }

    func themeCoosing(with theme: ThemeType) -> some View {
        Button {
//            cardsContent = theme.preparedCards
        } label: {
            VStack {
                Image(systemName: theme.imageName)
                    .imageScale(.large)
                    .font(.title)
                Text(theme.rawValue)
            }
        }
    }

}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
