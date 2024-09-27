//
//  TripDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 03/09/2024.
//

import MapKit
import SwiftUI

struct TripDetailView: View {
    @Bindable var trip: Trip
    var tripList: Namespace.ID
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.deviceType) private var deviceType
    @State var mapRegion = MapCameraPosition.automatic

    var body: some View {

        Map(position: $mapRegion) {
            ForEach(trip.steps) { step in
                Marker("", coordinate: step.coordinate)
            }
        }
            .if(verticalSizeClass == .regular && horizontalSizeClass == .compact) { map in
                map.safeAreaInset(edge: .bottom) {
                    StepView(trip: trip)
                        .frame(height: 400)
                }
            }
            .if(verticalSizeClass == .regular && horizontalSizeClass == .regular) { map in
                map.safeAreaInset(edge: .trailing) {
                    StepView(trip: trip)
                        .frame(width: 400)
                }
            }
            .if(verticalSizeClass == .compact && horizontalSizeClass == .compact) { map in
                map.safeAreaInset(edge: .trailing) {
                    StepView(trip: trip)
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
