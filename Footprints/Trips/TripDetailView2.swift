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
                StepDetailView2(step: step)
            }
    }
    
    func addStep() {
        let location = getLocation()
        
        let newStep = Step(
            timestamp: Date.now,
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude)
        
        modelContext.insert(newStep)
        navigation.navigationPath.append(newStep)
    }
    
    func getLocation() -> CLLocation {
        if let location = getPreciseLocation() {
            return location
        } else {
            let localeRegion = LocaleProvider.getLocale()
            let regions = LocaleProvider.regionsCoordinates
            
            let region = regions.first(where: { $0.name == localeRegion })
            return CLLocation(
                latitude: region?.latitude ?? 0.0,
                longitude: region?.longitude ?? 0.0
            )
        }
    }
    
    func getPreciseLocation() -> CLLocation? {
        return nil
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
                    .environment(NavigationController.preview)
            }
        }
    }
}
