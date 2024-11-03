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
    @State private var selectedTab: Tabs = .trips

    var body: some View {
        let _ = print(modelContext.sqliteCommand)
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
}

#Preview(traits: .previewData) {
    ContentView()
}
