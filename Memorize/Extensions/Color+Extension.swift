//
//  Color+Extension.swift
//  Memorize
//
//  Created by Никита Аршинов on 3.05.25.
//

import SwiftUI

extension Color {
    static func randomColor() -> Color {
        Color(
            red: Double.random(in: 0.0..<1.0),
            green: Double.random(in: 0.0..<1.0),
            blue: Double.random(in: 0.0..<1.0)
        )
    }
}
