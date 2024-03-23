//
//  TripDetailView2.swift
//  Footprints
//
//  Created by Jill Allan on 22/03/2024.
//

import MapKit
import SwiftUI

struct TripDetailView2: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var trip: Trip
    
    @Environment(NavigationController.self) private var navigation
    
    var body: some View {
        Map()
            .navigationTitle(trip.title)
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add step", systemImage: "plus", action: addStep)
                }
            }
            .navigationDestination(for: Step.self) { step in
                Text("New step")
            }
    }
    
    func addStep() {
        // TODO: comment
        let newStep = Step(timestamp: Date.now, latitude: 51.5, longitude: 0.0)
        modelContext.insert(newStep)
        navigation.navigationPath.append(newStep)
    }
}

#Preview("iPhone") {
    ModelPreview {
        SampleContainer.sample()
    } content: {
        TabView {
            NavigationStack {
                TripDetailView2(trip: .bedminsterToBeijing)
            }
        }
    }
}

#Preview("iPad") {
    ModelPreview {
        SampleContainer.sample()
    } content: {
        NavigationSplitView {
            Text("Sidebar")
        } detail: {
            NavigationStack {
                TripDetailView2(trip: .bedminsterToBeijing)
            }
        }
    }
}
