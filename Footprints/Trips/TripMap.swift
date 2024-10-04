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
        Map(position: $mapRegion, selection: $selectedStep) {
//            UserAnnotation()
            MapPolyline(coordinates: trip.tripSteps.map(\.coordinate), contourStyle: .geodesic)
                .stroke(Color.accentColor, lineWidth: 25/10)
            ForEach(trip.tripSteps) { step in
                Annotation(
                    step.timestamp.formatted(date: .abbreviated, time: .shortened),
                    coordinate: step.coordinate
                ) {
                    Image(systemName: "circle")
                        .resizable()
                        .foregroundStyle(Color.accentColor)
                        .frame(width: 15, height: 15)
                        .background(Color.white)
                        .clipShape(.circle)
//                    Image(PreviewDataGenerator.randomTripImage)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 100, height: 25)
//                        .clipShape(.circle)
//                        .overlay(Circle().stroke(Color.white, lineWidth: 25/10))
                }
                .tag(step)
                .annotationTitles(.hidden)
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
