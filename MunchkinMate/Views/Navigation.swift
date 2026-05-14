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
    @State var selection: Player?

    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                ForEach(viewModel.players, id: \.self) { player in
                    PlayerPreviewView(player: player)
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
                .onDelete {
                    for index in $0 {
                        viewModel.delete(viewModel.players[index])
                    }
                    guard let selection, !viewModel.players.contains(selection) else { return }
                    self.selection = nil
                }
            }
            .listStyle(.inset)
            .navigationTitle("Players")
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
            if let selection {
                PlayerDetail(player: selection)
                    .id(selection.id)
            } else {
                Text("Select a Player")
            }
        }
        .onAppear {
            viewModel.fetchData()
        }
    }

    private func addItem() {
        withAnimation {
            let player = Player()
            viewModel.add(player)
            selection = player
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
