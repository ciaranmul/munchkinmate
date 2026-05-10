//
//  Item.swift
//  MunchkinMate
//
//  Created by Ciarán Mulholland on 07/05/2026.
//

import Foundation
import SwiftData
import SwiftUI

struct ColorValues: Codable {
}

@Model
final class Player {
    var uuid = UUID()
    var name: String = "Player"
    var isMale: Bool = true
    private(set) var level: Int = 0
    private(set) var combatModifier: Int = 0

    // Player Colour Values
    private(set) var red: Double = Double.random(in: 0...1)
    private(set) var green: Double = Double.random(in: 0...1)
    private(set) var blue: Double = Double.random(in: 0...1)

    init(name: String = "Player",
         isMale: Bool = true,
         level: Int = 0,
         combatModifier: Int = 0,
         red: Double = Double.random(in: 0...1),
         green: Double = Double.random(in: 0...1),
         blue: Double = Double.random(in: 0...1)) {
        self.name = name
        self.isMale = isMale
        self.level = level
        self.combatModifier = combatModifier
        self.red = red
        self.green = green
        self.blue = blue
    }
}

extension Player {
    var color: Color {
        Color(red: red, green: green, blue: blue)
    }

    var combatLevel: Int {
        level + combatModifier
    }

    var displayGender: String {
        isMale ? "Male" : "Female"
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
