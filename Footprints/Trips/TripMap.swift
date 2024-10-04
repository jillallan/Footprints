//
//  TripMap.swift
//  Footprints
//
//  Created by Jill Allan on 04/10/2024.
//

import MapKit
import SwiftUI

struct TripMap: View {
    @Bindable var trip: Trip
    @State var mapRegion = MapCameraPosition.automatic
    @Binding var selectedStep: Step?
    
    var body: some View {
        MapReader { mapProxy in
            Map(position: $mapRegion, selection: $selectedStep) {
                UserAnnotation()
                MapPolyline(coordinates: trip.tripSteps.map(\.coordinate), contourStyle: .geodesic)
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
            .onTapGesture { cgPoint in
                if let coordinate = mapProxy.convert(cgPoint, from: .local) {
                    print("tapped at: \(coordinate)")
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

#Preview {
    TripMap(trip: .bedminsterToBeijing, selectedStep: .constant(Step.bedminsterStation))
}
