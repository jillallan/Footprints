//
//  TripDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 30/10/2023.
//

import MapKit
import OSLog
import SwiftData
import SwiftUI

struct TripDetailView: View {
    private let logger = Logger(category: String(describing: TripDetailView.self))
    
    @Environment(LocationHandler.self) private var locationHandler
    @State private var currentLocation: CLLocation?
    
    // MARK: - Data Properties
    @Environment(\.modelContext) private var modelContext
    @Bindable var trip: Trip
    @State var isNewTrip: Bool = false
    
    // MARK: - Map Properties
    @State var position = MapCameraPosition.automatic
    @State var stepId: PersistentIdentifier?
    
    // MARK: - Navigation Properties
    @Binding var navigationPath: NavigationPath
    
    // MARK: - View Properties
    @State var aspectRatio: AspectRatio = .zero(AspectRatio: 0.0)
    
    var body: some View {
        let _ = logger.debug("\(currentLocation)")
        VStack {
            Text(currentLocation.debugDescription)
            Map(position: $position) {
                ForEach(trip.tripSteps) { step in
                    Annotation("", coordinate: step.coordinate) {
                        Image(systemName: "circle")
                            .resizable()
                            .foregroundStyle(.indigo)
                            .frame(width: 10.0, height: 10.0)
                            .background(Color.indigo)
                            .clipShape(.circle)
                    }
                }
                MapPolyline(coordinates: trip.tripSteps.map(\.coordinate), contourStyle: .geodesic)
                    .stroke(Color.indigo, style: StrokeStyle(lineWidth: 2.0))
            }
            .dynamicSafeAreaInset(edge: scrollEdge) {
                ActivityScroll(trip: trip, steps: trip.tripSteps, aspectRatio: $aspectRatio, scrollPositionID: $stepId)
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
            .onChange(of: stepId) {
                if let step = getStep(for: stepId) {
                    withAnimation {
                        position = MapCameraPosition.item(step.mapItem)
                    }
                } else if let trip = getTrip(for: stepId) {
                    withAnimation {
                        position = MapCameraPosition.region(trip.tripRegion)
                    }
                }
            }
            .task {
                await getCurrentLocation()
            }
            .onAppear {
                if modelContext.insertedModelsArray.contains(where: { $0.persistentModelID == trip.persistentModelID }) {
                    isNewTrip = true
                }
            }
        }
        .sheet(isPresented: $isNewTrip) {
            AddTripView(trip: trip)
        }
        
#if os(iOS)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
#endif
        .getAspectRatio($aspectRatio)
        
    }
    
    var scrollEdge: Edge {
        switch aspectRatio {
        case .landscape(_), .wide(_): Edge.leading
        case .square(_), .portrait(_), .tall(_), .zero(AspectRatio: _): Edge.bottom
        }
    }
    
    var verticleEdge: VerticalEdge? {
        switch scrollEdge {
        case .top: VerticalEdge.top
        case .bottom: VerticalEdge.bottom
        default: nil
        }
    }
    
    var horizontalEdge: HorizontalEdge? {
        switch scrollEdge {
        case .leading: HorizontalEdge.leading
        case .trailing: HorizontalEdge.trailing
        default: nil
        }
    }
    
    func getCurrentLocation() async {
        do {
            currentLocation = try await locationHandler.currentLocation()
            logger.debug("\(currentLocation.debugDescription)")
        } catch {
            currentLocation = CLLocation(latitude: 51.5, longitude: 0.0)
            logger.debug("\(currentLocation.debugDescription)")
        }
    }
    
    func addStep() async {
        // FIXME: Add location from local, location or last step
        
        guard let currentLocation else { return }
        
        let newStep = Step(
            timestamp: .now,
            latitude: currentLocation.coordinate.latitude,
            longitude: currentLocation.coordinate.longitude
        )
        
        newStep.trip = trip
        modelContext.insert(newStep)
        navigationPath.append(newStep)
    }
    

    
    func getStep(for stepId: PersistentIdentifier?) -> Step? {
        guard let stepId else { return nil }
        guard let step = modelContext.model(for: stepId) as? Step else { return nil }
        
        logger.debug("step: \(String(describing: step.debugDescription))")
        return step
    }
    
    func getTrip(for tripId: PersistentIdentifier?) -> Trip? {
        guard let tripId else { return nil }
        guard let trip = modelContext.model(for: tripId) as? Trip else { return nil }
        
        return trip
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
    TabView {
        NavigationStack {
            ModelPreview {
                SampleContainer.sample()
            } content: {
                TripDetailView(trip: .bedminsterToBeijing, navigationPath: .constant(NavigationPath()))
            }
        }
    }
    .environment(LocationHandler.preview)
}

