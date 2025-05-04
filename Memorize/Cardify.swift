//
//  Cardify.swift
//  Memorize
//
//  Created by Никита Аршинов on 4.05.25.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            base
                .strokeBorder(lineWidth: 2)
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
    }
    
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
