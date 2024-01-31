//
//  TripDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 30/10/2023.
//

import MapKit
import SwiftData
import SwiftUI

struct TripDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var trip: Trip
    @Binding var navigationPath: NavigationPath
    @State var aspectRatio: AspectRatio = .zero(AspectRatio: 0.0)
    
    var body: some View {
        VStack {
            Map()
                .dynamicSafeAreaInset(edge: scrollEdge) {
                    ActivityScroll(trip: trip, steps: trip.tripSteps, aspectRatio: $aspectRatio)
                }
                .navigationTitle(trip.title)
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            addStep()
                        } label: {
                            Label("Add step", systemImage: "plus")
                        }
                    }
                }
        }

#if os(iOS)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
#endif
        .getAspectRatio($aspectRatio)

    }
    
    var scrollEdge: Edge {
        switch aspectRatio {
        case .landscape(_), .wide(_):
            return .leading
        case .square(_), .portrait(_), .tall(_), .zero(AspectRatio: _):
            return .bottom
        }
    }
    
    var verticleEdge: VerticalEdge? {
        switch scrollEdge {
        case .top:
            return VerticalEdge.top
        case .bottom:
            return VerticalEdge.bottom
        default:
            return nil
        }
    }
    
    var horizontalEdge: HorizontalEdge? {
        switch scrollEdge {
        case .leading:
            return HorizontalEdge.leading
        case .trailing:
            return HorizontalEdge.trailing
        default:
            return nil
        }
    }
    
    func addStep() {
        // FIXME: Add location from local, location or last step
        let newStep = Step(timestamp: .now, latitude: 51.5, longitude: 0.0)
        newStep.trip = trip
        modelContext.insert(newStep)
        navigationPath.append(newStep)
    }
}

#Preview {
    ModelPreview(SampleContainer.sample) {
        TabView {
            NavigationStack {
                TripDetailView(trip: .bedminsterToBeijing, navigationPath: .constant(NavigationPath()))
            }
        }
    }
}
