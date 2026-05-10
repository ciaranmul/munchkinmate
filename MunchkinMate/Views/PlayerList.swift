//
//  PlayerList.swift
//  MunchkinMate
//
//  Created by Ciarán Mulholland on 07/05/2026.
//

import SwiftUI

struct PlayerList: View {
    @Binding var players: [Player]
    @State var selectedPlayer: Player? = nil
    var onDelete: ((Player) -> Void) = { _ in }

    var body: some View {
        List(selection: $selectedPlayer) {
            ForEach(players) { player in
                NavigationLink {
                    PlayerDetail(player: player)
                } label: {
                    PlayerPreviewView(player: player)
                }
                .padding(8)
                .background {
                    player.color
                        .overlay {
                            Color.black.opacity(0.5)
                        }
                        .mask {
                            RoundedRectangle(cornerRadius: 12)
                        }
                }
            }
            .onDelete { offsets in
                for index in offsets {
                    onDelete(players[index])
                }
            }
            #if os(macOS)
            .onDeleteCommand {
                guard let selectedPlayer else { return }
                onDelete(selectedPlayer)
                self.selectedPlayer = nil
            }
            #endif
        }
        .listStyle(.inset)
        .navigationTitle("Players")
    }
}

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

#Preview {
    PlayerList(players: .constant([Player(), Player(), Player()]),
               selectedPlayer: nil,
               onDelete: { _ in })
}
