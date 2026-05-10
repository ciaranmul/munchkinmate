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

    var body: some View {
        Navigation(viewModel: .init(modelContext: modelContext))
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Player.self, inMemory: true)
}
