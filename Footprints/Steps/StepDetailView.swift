//
//  StepDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 06/10/2024.
//

import MapKit
import SwiftUI

struct StepDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var locationService = LocationService()
    @Bindable var step: Step
    @State private var mapItem: MKMapItem?
    @State private var isStepEditingViewPresented: Bool = false
//    var stepList: Namespace.ID
    
    var body: some View {
        ScrollView {
            DatePicker("Step Date", selection: $step.timestamp, displayedComponents: [.date, .hourAndMinute])
                .padding()
            LazyVStack {
                Button {
                    isStepEditingViewPresented.toggle()
                } label: {
                    StepMap(step: step, mapItem: $mapItem)
                }
                .buttonStyle(.plain)
                ForEach(0..<3) { int in
                    Image(.EBC_1)
                        .resizable()
                        .scaledToFit()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
            .padding()
            
        }
        .navigationTitle(step.stepTitle)
        .toolbarBackground(.hidden, for: .navigationBar)
        .sheet(isPresented: $isStepEditingViewPresented) {
            if let mapItem {
                let newLocation = Location(
                    coordinate: mapItem.placemark.coordinate,
                    mapItem: mapItem, resultType: .pointOfInterest
                )
                modelContext.insert(newLocation)
                newLocation.steps.append(step)
            }
        } content: {
            LocationEditingView(
                mapRegion: MapCameraPosition.region(step.region),
                mapItemIdentifier: step.location?.mapItemIdentifier ?? "",
                mapItem: $mapItem
            ) { item in
                mapItem = item
            }
            .presentationDragIndicator(.visible)
        }
        .onAppear {
            Task {
//                mapItem = await fetchMapItem(for: step.location?.mapItemIdentifier ?? "")
                mapItem = decodeMapItem(step: step)
            }
        }
    }
    
    func decodeMapItem(step: Step) -> MKMapItem? {
        guard let data = step.location?.encodedMapItem else { return nil }
        var mapItem: MKMapItem? = nil
        
        if let decodedMapItem = MKMapItem.decode(from: data) {
            mapItem = decodedMapItem
            print("decoded map item: \(String(describing: mapItem))")
        }
        return mapItem
    }
    
    func fetchMapItem(for identifier: String) async -> MKMapItem? {
        var mapItem: MKMapItem? = nil
        do {
            mapItem = try await locationService.fetchMapItem(for: identifier)
        } catch {
            
        }
        return mapItem
    }
}

#Preview(traits: .previewData) {
//    @Previewable @Namespace var namespace
    
    NavigationStack {
        StepDetailView(
            step: .atomium
//            , stepList: namespace
        )
    }
}
