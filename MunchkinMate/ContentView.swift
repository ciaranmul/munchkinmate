//
//  ContentView.swift
//  MunchkinMate
//
//  Created by Ciarán Mulholland on 07/05/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var players: [Player]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(players) { player in
                    NavigationLink {
                        VStack {
                            Text(player.name)
                            Text("Gender: \(player.isMale ? "Male" : "Female")")
                            Text("Level: \(player.level)")
                            Text("Combat: \(player.combatLevel)")
                        }
                    } label: {
                        Text("Player: \(player.name)")
                    }
                }
                .onDelete(perform: deleteItems)
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select a Player")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Player()
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(players[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Player.self, inMemory: true)
}
