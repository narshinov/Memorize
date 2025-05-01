//
//  ContentView.swift
//  Memorize
//
//  Created by Никита Аршинов on 1.05.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
        }
    }
}

#Preview {
    ContentView()
}
