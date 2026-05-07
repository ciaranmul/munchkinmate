//
//  Item.swift
//  Munchkin Mate
//
//  Created by Ciarán Mulholland on 07/05/2026.
//

import Foundation
import SwiftData

@Model
final class Player {
    var name: String
    var isMale: Bool
    private(set) var level: Int
    private(set) var combatModifier: Int

    init(name: String = "Player",
         isMale: Bool = true,
         level: Int = 0,
         combatModifier: Int = 0) {
        self.name = name
        self.isMale = isMale
        self.level = level
        self.combatModifier = combatModifier
    }
}

extension Player {
    var combatLevel: Int {
        level + combatModifier
    }

    func incrementCombatModifier() {
        combatModifier += 1
    }

    func decrementCombatModifier() {
        combatModifier = max(combatModifier - 1, 0)
    }

    func incrementLevel() {
        level += 1
    }

    func decrementLevel() {
        level = max(level - 1, 0)
    }

    func toggleGender() {
        isMale.toggle()
    }
}
