//
//  TripDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 03/09/2024.
//

import MapKit
import SwiftData
import SwiftUI

struct TripDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.deviceType) private var deviceType

    @Bindable var trip: Trip
    var tripList: Namespace.ID

    @State var mapRegion = MapCameraPosition.automatic
    @State private var selectedStep: Step?

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

            .if(verticalSizeClass == .regular && horizontalSizeClass == .compact) { map in
                map.safeAreaInset(edge: .bottom) {
                    StepView(trip: trip, selectedStep: $selectedStep)
                        .frame(height: 400)
                     
                }
            }
            .if(verticalSizeClass == .regular && horizontalSizeClass == .regular) { map in
                map.safeAreaInset(edge: .trailing) {
                    StepView(trip: trip, selectedStep: $selectedStep)
                        .frame(width: 400)
                }
            }
            .if(verticalSizeClass == .compact && horizontalSizeClass == .compact) { map in
                map.safeAreaInset(edge: .trailing) {
                    StepView(trip: trip, selectedStep: $selectedStep)
                        .frame(width: 400)
                }
            }
            .navigationTitle(trip.title)
#if !os(macOS)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbarVisibility(deviceType == .pad ? .visible : .hidden, for: .tabBar)
            .navigationTransition(.zoom(sourceID: trip.id, in: tripList))
#elseif os(macOS)
            .toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
        //        .navigationTransition(.automatic)
#endif
            .navigationDestination(for: Step.self) { step in
                Text(step.timestamp, style: .date)
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

    func getStep(for id: PersistentIdentifier?) -> Step? {
        guard let id else { return nil }
        guard let step = modelContext.model(for: id) as? Step else {
            return nil
        }
        return step
    }
}

#Preview(traits: .previewData) {
    @Previewable @Namespace var namespace

    TabView {
        Tab("Trips", systemImage: "suitcase") {
            NavigationStack {
                TripDetailView(trip: .bedminsterToBeijing, tripList: namespace)
            }
        }
    }
    .tabViewStyle(.sidebarAdaptable)

}
