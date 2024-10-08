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
    @EnvironmentObject var navigationController: NavigationController

    @Bindable var trip: Trip
    var tripList: Namespace.ID
    @Namespace var stepList

    @State var isEditing: Bool = false
    @State var mapRegion = MapCameraPosition.automatic
    @State private var selectedStep: Step?

    var body: some View {
        TripMap(
            trip: trip,
            selectedStep: $selectedStep
        )

            .if(verticalSizeClass == .regular && horizontalSizeClass == .compact) { map in
                map.safeAreaInset(edge: .bottom) {
                    StepView(trip: trip, selectedStep: $selectedStep, stepList: stepList)
                        .frame(height: 400)
                     
                }
            }
            .if(verticalSizeClass == .regular && horizontalSizeClass == .regular) { map in
                map.safeAreaInset(edge: .trailing) {
                    StepView(trip: trip, selectedStep: $selectedStep, stepList: stepList)
                        .frame(width: 400)
                }
            }
            .if(verticalSizeClass == .compact && horizontalSizeClass == .compact) { map in
                map.safeAreaInset(edge: .trailing) {
                    StepView(trip: trip, selectedStep: $selectedStep, stepList: stepList)
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
            .toolbar {
                Button("Add Step", systemImage: "plus") {
                    let step = Step()
                    trip.steps.append(step)
                    modelContext.insert(step)
                    navigationController.navigationPath.append(step)
                }
//                .matchedTransitionSource(id: newStep.id, in: stepList)
            }
            .navigationDestination(for: Step.self) { step in
                AddStepView(trip: trip, step: step)
            }
    }
}

#Preview("view mode", traits: .previewData, .previewNavigation) {
    @Previewable @Namespace var namespace
    @Previewable @State var isEditing: Bool = false

    TabView {
        Tab("Trips", systemImage: "suitcase") {
            NavigationStack {
                TripDetailView(
                    trip: .bedminsterToBeijing,
                    tripList: namespace
                   , isEditing: isEditing
                )
            }
        }
    }
    .tabViewStyle(.sidebarAdaptable)

}

#Preview("edit mode", traits: .previewData, .previewNavigation) {
    @Previewable @Namespace var namespace
    @Previewable @State var isEditing: Bool = true

    TabView {
        Tab("Trips", systemImage: "suitcase") {
            NavigationStack {
                TripDetailView(
                    trip: .bedminsterToBeijing,
                    tripList: namespace,
                    isEditing: isEditing
                )
            }
        }
    }
    .tabViewStyle(.sidebarAdaptable)

}
