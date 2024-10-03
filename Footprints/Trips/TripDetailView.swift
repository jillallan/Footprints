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
    @Bindable var trip: Trip
    var tripList: Namespace.ID
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.deviceType) private var deviceType
    @State var mapRegion = MapCameraPosition.automatic
    @State private var position: PersistentIdentifier?
    @State private var currentStep: Step?
    @State private var selectedMapStep: Step?

    var body: some View {

        Map(position: $mapRegion, selection: $selectedMapStep) {
            ForEach(trip.steps) { step in
                Marker(step.timestamp.formatted(date: .abbreviated, time: .shortened), coordinate: step.coordinate)
                    .annotationTitles(.hidden)
                    .tag(step)
            }
        }

            .if(verticalSizeClass == .regular && horizontalSizeClass == .compact) { map in
                map.safeAreaInset(edge: .bottom) {
                    StepView(trip: trip, position: $position, selectedStep: $selectedMapStep)
                        .frame(height: 400)
                     
                }
            }
            .if(verticalSizeClass == .regular && horizontalSizeClass == .regular) { map in
                map.safeAreaInset(edge: .trailing) {
                    StepView(trip: trip, position: $position, selectedStep: $selectedMapStep)
                        .frame(width: 400)
                }
            }
            .if(verticalSizeClass == .compact && horizontalSizeClass == .compact) { map in
                map.safeAreaInset(edge: .trailing) {
                    StepView(trip: trip, position: $position, selectedStep: $selectedMapStep)
                        .frame(width: 400)
                }
            }
            .navigationTitle(trip.title)
#if !os(macOS)
//            .toolbarBackground(.hidden, for: .navigationBar)
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
            .onChange(of: position) {
                if let step = getStep(for: position) {
                    print(step.timestamp.formatted(date: .abbreviated, time: .shortened))
                    withAnimation {
                        updateMapPosition(for: step)
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
