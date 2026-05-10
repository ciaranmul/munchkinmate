//
//  Navigation.swift
//  MunchkinMate
//
//  Created by Ciarán Mulholland on 07/05/2026.
//

import SwiftData
import SwiftUI

struct Navigation: View {
    @State var viewModel: ViewModel

    var body: some View {
        NavigationSplitView {
            PlayerList(players: $viewModel.players) { player in
                viewModel.delete(player)
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
        .onAppear {
            viewModel.fetchData()
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Player()
            viewModel.add(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                viewModel.delete(viewModel.players[index])
            }
        }
    }
}

extension Navigation {
    @Observable
    class ViewModel {
        var players: [Player] = []
        let modelContext: ModelContext
        var error: Error?

        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            self.players = []
        }

        func fetchData() {
            do {
                let descriptor = FetchDescriptor<Player>(sortBy: [SortDescriptor(\.name)])
                players = try modelContext.fetch(descriptor)
            } catch {
                self.error = error
            }
        }

        func delete(_ player: Player) {
            defer {
                fetchData()
            }

            modelContext.delete(player)
        }

        func add(_ player: Player) {
            defer {
                fetchData()
            }

            modelContext.insert(player)
        }
    }
}
