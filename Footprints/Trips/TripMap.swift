//
//  TripMap.swift
//  Footprints
//
//  Created by Jill Allan on 04/10/2024.
//

import MapKit
import SwiftUI

struct TripMap: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var trip: Trip
    @State var mapRegion = MapCameraPosition.automatic
    @Binding var selectedStep: Step?
    
    var body: some View {
        MapReader { mapProxy in
            Map(position: $mapRegion, selection: $selectedStep) {

                MapPolyline(
                    coordinates: trip.tripSteps.map(\.coordinate),
                    contourStyle: .geodesic
                )
                .stroke(Color.accentColor, lineWidth: 25/10)
            
                ForEach(trip.tripSteps) { step in
                    Annotation(
                        step.timestamp.formatted(date: .abbreviated, time: .shortened),
                        coordinate: step.coordinate
                    ) {
                        DefaultStepMapAnnotation()
                    }
                    .tag(step)
                    .annotationTitles(.hidden)
                }
            }
        }
        .onAppear {
            mapRegion = MapCameraPosition.region(trip.tripRegion)
        }
        .onChange(of: selectedStep) {
            if let selectedStep {
                withAnimation {
                    updateMapPosition(for: selectedStep)
                }
            }
        }
    }
    
    func updateMapPosition(for step: Step) {
        mapRegion = MapCameraPosition.region(step.region)
    }
}

#Preview("view mode", traits: .previewData) {
    TripMap(
        trip: .bedminsterToBeijing,
        selectedStep: .constant(Step.bedminsterStation)
    )
}

#Preview("edit mode", traits: .previewData) {
    TripMap(
        trip: .bedminsterToBeijing,
        selectedStep: .constant(Step.bedminsterStation)
    )
}

#Preview("edit mode step added", traits: .previewData) {
    let step = Step(timestamp: Date.now, latitude: 51.5, longitude: 0.5)
    
    TripMap(
        trip: .bedminsterToBeijing,
        selectedStep: .constant(Step.bedminsterStation)
    )
}
