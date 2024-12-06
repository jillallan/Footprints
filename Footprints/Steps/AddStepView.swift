//
//  AddStepView.swift
//  Footprints
//
//  Created by Jill Allan on 06/12/2024.
//

import CoreLocation
import MapKit
import SwiftData
import SwiftUI

struct AddStepView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @State private var isLocationDetailViewPresented: Bool = false
    @State private var date: Date = .now
    @State private var locationTitle: String = ""
    @State private var selectedMapItem: MKMapItem?
    @Bindable var trip: Trip

    var body: some View {
        NavigationStack {
            Form {
                Button {
                    isLocationDetailViewPresented.toggle()
                } label: {
                    Map {
                        if let selectedMapItem {
                            Marker(item: selectedMapItem)
                        }
                        
                    }
                        .frame(height: 400)
                }
                .buttonStyle(.plain)
                
                TextField("Location Name", text: $locationTitle)
                DatePicker("Step Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                if let selectedMapItem {
                    Button("Add Step") {
                        addStep(mapItem: selectedMapItem)
                        dismiss()
                    }
                }
            }
            .navigationTitle("New Step")
            .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
            .sheet(isPresented: $isLocationDetailViewPresented) {
                // TODO: -
            } content: {
                LocationDetailView(currentLocation: CLLocationCoordinate2D.defaultCoordinate()) { mapItem in
                    selectedMapItem = mapItem
                    if locationTitle == "" {
                        locationTitle = selectedMapItem?.name ?? "Unknown Location"
                    }
                }
            }
        }
    }
    
    func addStep(mapItem: MKMapItem) {
        let newLocation = Location(mapItem: mapItem)
        modelContext.insert(newLocation)
    
        let newStep = Step(
            title: locationTitle,
            timestamp: date,
            latitude: newLocation.latitude,
            longitude: newLocation.longitude
        )
        modelContext.insert(newStep)
        
        newLocation.steps.append(newStep)
        trip.steps.append(newStep)
    }
}

#Preview(traits: .previewData) {
    AddStepView(trip: .anglesey)
}
