//
//  Array+Extension.swift
//  Memorize
//
//  Created by Никита Аршинов on 3.05.25.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
