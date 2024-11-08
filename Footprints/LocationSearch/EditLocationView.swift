//
//  EditLocationView.swift
//  Footprints
//
//  Created by Jill Allan on 08/11/2024.
//

import MapKit
import SwiftData
import SwiftUI

struct EditLocationView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var locationService = LocationService()
    @State var location: Location
    @State var mapSelection: MapSelection<MKMapItem>?
    @State private var mapItemDetailIsPresented: Bool = false
    @State var loadingState: LoadingState = .loading
    @State var mapItem: MKMapItem?
    let locationClosure: (PersistentIdentifier) -> Void
    
    var body: some View {
        NavigationStack {
            EditLocationMap(location: $location, mapSelection: $mapSelection)
                .navigationTitle("Edit Location")
                .toolbarBackground(.hidden, for: .navigationBar)
                .sheet(isPresented: $mapItemDetailIsPresented) {
                    // TODO: -
                } content: {
                    EditMapItemDetail(
                        loadingState: $loadingState,
                        mapItem: $mapItem
                    ) { mapItem in
                        if let mapItem {
                            let newLocation = Location(mapItem: mapItem)
                            modelContext.insert(newLocation)
                            locationClosure(newLocation.persistentModelID)
                        }
                    }
                    .mapDetailPresentationStyle()
                }
                .onChange(of: mapSelection) {
                    mapItemDetailIsPresented = true
                    Task {
                        if let mapFeature = mapSelection?.feature {
                            mapItem = await fetchMapItem(for: mapFeature)
                        }
                        if let selectedMapItem = mapSelection?.value {
                            mapItem = assignMapItem(for: selectedMapItem)
                        }
                    }
                }

        }
    }
    
    func fetchMapItem(for searchSuggestion: String) async -> MKMapItem? {
        print("is this called")
        var mapItem: MKMapItem? = nil
        do {
            if let fetchedMapItem = try await locationService.fetchMapItems(for: searchSuggestion).first {
                mapItem = fetchedMapItem
                print(mapItem.debugDescription)
                loadingState = .success
            } else {
                loadingState = .failed
            }
        } catch {
            loadingState = .failed
        }
        return mapItem
    }
    
    func fetchMapItem(for mapFeature: MapFeature) async -> MKMapItem? {
        print("is this called 2")
        let request = MKMapItemRequest(feature: mapFeature)
        var mapItem: MKMapItem? = nil
        do {
            mapItem = try await request.mapItem
            print(mapItem.debugDescription)
            loadingState = .success
        } catch {
//            logger.error("Getting map item from identifier failed. Error: \(error.localizedDescription)")
            loadingState = .failed
        }
        return mapItem
    }
    
    func assignMapItem(for mapItem: MKMapItem) -> MKMapItem {
        loadingState = .success
        return mapItem
    }
}

#Preview(traits: .previewData) {
    let location = Step.stJohnsLane.location ?? Location(coordinate: Step.stJohnsLane.coordinate)
    let locationClosure: (PersistentIdentifier) -> Void = { _ in }
    
    NavigationStack {
        EditLocationView(
            location: location,
            mapSelection: MapSelection(location.mapItem), locationClosure: locationClosure
        )
    }
}
