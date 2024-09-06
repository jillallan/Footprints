//
//  ContentView.swift
//  Footprints
//
//  Created by Jill Allan on 09/08/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    @State private var selectedTab: Tabs = .trips

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(Tabs.trips.name, systemImage: Tabs.trips.symbol, value: .trips) {
                TripView()
            }
            Tab(Tabs.steps.name, systemImage: Tabs.steps.symbol, value: .steps) {
                Steps()
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview(traits: .previewData) {
    ContentView()
}
