//
//  TripDetailView2.swift
//  Footprints
//
//  Created by Jill Allan on 22/03/2024.
//

import MapKit
import SwiftUI

struct TripDetailView2: View {
    @Bindable var trip: Trip
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
    }
    
    func addStep() {
        // TODO: comment
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
