//
//  ThemeType.swift
//  Memorize
//
//  Created by Никита Аршинов on 2.05.25.
//

import Foundation

enum ThemeType: String, CaseIterable {
    case animals
    case vehicles
    case balls
    
    var content: [String] {
        switch self {
        case .animals:
            ["🐶", "🐭", "🐨", "🐵", "🐷", "🐮", "🐼", "🐸", "🦁"]
            
        case .vehicles:
            ["🚗", "🚕", "🚑", "🚎", "🚒", "🚓", "🚜", "🛵"]
            
        case .balls:
            ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🎱"]
        }
    }
    
    var imageName: String {
        switch self {
        case .animals:
            "pawprint.circle"
            
        case .vehicles:
            "car.circle"

        case .balls:
            "volleyball.circle"
        }
    }
    
    var preparedCards: [String] {
        (content + content).shuffled()
    }
}
