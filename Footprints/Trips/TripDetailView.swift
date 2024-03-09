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
    @Environment(LocationHandler.self) private var locationHandler
    
    // MARK: - Data Properties
    @Environment(\.modelContext) private var modelContext
    @Bindable var trip: Trip
    
    // MARK: - Navigation Properties
    @Binding var navigationPath: NavigationPath
    @State var aspectRatio: AspectRatio = .zero(AspectRatio: 0.0)
    @State private var currentLocation = CLLocation()
    
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
                            Task {
                                await addStep()
                            }
                        } label: {
                            Label("Add step", systemImage: "plus")
                        }
                    }
                }
                .onAppear {
                    locationHandler.requestLocation { location in
                    }
                }
                .task {

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
    
    func addStep() async {
        // FIXME: Add location from local, location or last step
//        locationHandler.requestLocation()
        
        let newStep = Step(
            timestamp: .now,
            latitude: currentLocation.coordinate.latitude,
            longitude: currentLocation.coordinate.longitude
        )
        newStep.trip = trip
        modelContext.insert(newStep)
        navigationPath.append(newStep)
    }
    
//    func upateLocation() async {
//        do {
//            let location = try await locationHandler.requestLocation()
//        } catch {
//            print(error)
//        }
//        
//    }
    
//    func updateLocation() async -> CLLocation? {
//        do {
//            // 1. Get the current location from the location manager
//            return try await locationHandler.currentLocation
//        
//            // 2. Update the camera position of the map to center around the user location
////            self.updateMapPosition()
//        } catch {
//            print("Could not get user location: \(error.localizedDescription)")
//        }
//        return nil
//    }
}

#Preview {
    ModelPreview(SampleContainer.sample) {
        TabView {
            NavigationStack {
                TripDetailView(trip: .bedminsterToBeijing, navigationPath: .constant(NavigationPath()))
                    .environment(LocationHandler.preview)
            }
        }
    }
}
