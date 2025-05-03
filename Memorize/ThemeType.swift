//
//  ThemeType.swift
//  Memorize
//
//  Created by Никита Аршинов on 3.05.25.
//

import Foundation
import SwiftUI

enum ThemeType: String, CaseIterable {
    case animals = "Animals"
    case vehicle = "Vehicle"
    case balls = "Balls"
    case food = "Food"
    case flowers = "Flowers"
    
    var emojis: [String] {
        switch self {
        case .animals:
            ["🐶", "🐭", "🐨", "🐵", "🐷", "🐮", "🐼", "🐸", "🦁"]
        case .vehicle:
            ["🚗", "🚕", "🚑", "🚎", "🚒", "🚓", "🚜", "🛵"]
        case .balls:
            ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🎱"]
        case .food:
            ["🎂", "🍔", "🥙", "🍪", "🍕", "🍩", "🥑", "🥝", "🍉"]
        case .flowers:
            ["🌱", "🌵", "🌷", "🪻", "🪷", "🌼", "🌻", "🌸", "🍀"]
        }
    }
}
