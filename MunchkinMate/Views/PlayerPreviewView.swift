//
//  PlayerPreviewView.swift
//  MunchkinMate
//
//  Created by Ciarán Mulholland on 14/05/2026.
//

import SwiftUI

struct PlayerPreviewView: View {
    @State var player: Player

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 8) {
                    Text(player.name)
                    Image(systemName: player.isMale ? "figure.stand" : "figure.stand.dress")
                }

                Text("Level: \(player.level)")
                Text("Combat: \(player.combatLevel)")
            }

            Spacer()
        }
        .foregroundStyle(.white)
        .compositingGroup()
    }
}
