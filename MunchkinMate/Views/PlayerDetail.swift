//
//  PlayerDetail.swift
//  MunchkinMate
//
//  Created by Ciarán Mulholland on 07/05/2026.
//

import SwiftUI

struct PlayerDetail: View {
    @State var player: Player

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Button {
                player.toggleGender()
            } label: {
                VStack {
                    Image(systemName: player.isMale ? "figure.stand" : "figure.stand.dress")
                    Text(player.displayGender)

                }
                .foregroundStyle(player.isMale ? .blue : .pink)
                .padding(24)
                .background {
                    Circle()
                }
            }

            TextField("Name", text: $player.name)
                .multilineTextAlignment(.center)
                .font(.largeTitle)

            Spacer()

            HStack {
                Text("Level:")

                Button(action: player.decrementLevel) {
                    Image(systemName: "minus.circle")
                }

                Text("\(player.level)")

                Button(action: player.incrementLevel) {
                    Image(systemName: "plus.circle")
                }
            }

            HStack {
                Text("Combat: ")

                Button(action: player.decrementCombatModifier) {
                    Image(systemName: "minus.circle")
                }

                Text("\(player.combatLevel)")

                Button(action: player.incrementCombatModifier) {
                    Image(systemName: "plus.circle")
                }
            }

            Spacer()
        }
        .foregroundStyle(.white)
        .padding(24)
        .background {
            player.color
                .overlay {
                    Color.black.opacity(0.5)
                }
                .ignoresSafeArea()
        }
    }
}

#Preview {
    PlayerDetail(player: Player())
}
