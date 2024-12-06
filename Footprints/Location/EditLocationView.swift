//
//  EditLocationView.swift
//  Footprints
//
//  Created by Jill Allan on 08/11/2024.
//

import MapKit
import OSLog
import SwiftData
import SwiftUI

struct EditLocationView: View {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: EditLocationView.self)
    )
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var locationService = LocationService()
    
    // MARK: - Search Properties
    @State private var locationSuggestionSearch = LocationSuggestionSearch()
    @State private var locationSuggestions: [LocationSuggestion] = []
    @State private var selectedLocationSuggestion: LocationSuggestion?
    @State private var searchQuery: String = ""
    
    // MARK: - Location Properties
    @State var mapItem: MKMapItem?
    @State var mapItems: [MKMapItem] = []
    @State var mapSelection: MapSelection<MKMapItem>?
    @State private var isMapItemDetailPresented: Bool = false
    @State private var isMapItemListPresented: Bool = false
    @State var loadingState: LoadingState = .loading
    @State var tappedLocation: Coordinate?
    let locationClosure: (PersistentIdentifier?) -> Void
    
    var body: some View {
//        let  _ = logger.debug("tapped location in view: \(String(describing: tappedLocation))")
        NavigationStack {
//            EditLocationMapOld(mapItem: $mapItem, mapSelection: $mapSelection, tappedLocation: $tappedLocation)
//                .searchable(text: $searchQuery, prompt: "Search for a location")
//                .searchSuggestions {
//                    ForEach(locationSuggestions) { suggestion in
//                        Button {
//                            selectedLocationSuggestion = suggestion
//                        } label: {
//                            LocationSuggestionRow(locationSuggestion: suggestion)
//                        }
//                        .buttonStyle(.plain)
//                    }
//                }
//                .navigationTitle("Edit Location")
//                .toolbarBackground(.hidden, for: .navigationBar)
////                .sheet(isPresented: $isMapItemDetailPresented) {
////                    EditMapItemDetail(loadingState: $loadingState, mapItem: $mapItem) { mapItem in
////                        let locationID = saveLocation(mapItem: mapItem)
////                        locationClosure(locationID)
////                        if mapItem != nil {
////                            dismiss()
////                        }
////                    }
////                    .mapDetailPresentationStyle()
////                }
//                .sheet(item: $tappedLocation) { coordinate in
////                    isMapItemListPresented.toggle()
//                    PlacemarkSheet()
//                }
//                .sheet(isPresented: $isMapItemListPresented) {
//                    MapItemSuggestions(loadingState: $loadingState, mapItems: $mapItems)
//                        .mapDetailPresentationStyle()
//                }
//                .onChange(of: mapSelection) {
//                    isMapItemDetailPresented = true
//                    Task {
//                        if selectedLocationSuggestion != nil { return }
//                        if tappedLocation != nil { return }
//                        guard let mapFeature = mapSelection?.feature else { return }
//                        guard let fetchedMapItem = await fetchMapItem(for: mapFeature) else { return }
//                        mapItem = fetchedMapItem
//                        guard let selectedMapItem = mapSelection?.value else { return }
//                        mapItem = assignMapItem(for: selectedMapItem)
//                    }
//                }
//                .onChange(of: searchQuery) {
//                    Task { await updateSearchResults() }
//                }
//                .onChange(of: selectedLocationSuggestion) {
//                    Task { await fetchMapItem(for: selectedLocationSuggestion) }
//                }
//                .onChange(of: tappedLocation) {
//                    Task {
//                        await fetchMapItems(for: tappedLocation)
//                    }
//                }
        }
    }
    
    func updateSearchResults() async {
        let region = mapItem?.placemark.coordinate.calculateRegion(metersSpan: 500)
        do {
            locationSuggestions = try await locationSuggestionSearch.fetchLocationSuggestions(for: searchQuery, in: region)
        } catch {
             logger.error("Failed to fetch search results: \(error.localizedDescription)")
        }
    }
    
    func fetchMapItem(for locationSuggestion: LocationSuggestion?) async {
        isMapItemDetailPresented = true
        guard let searchString = selectedLocationSuggestion?.mapItemSearchTerm else { return }
        do {
            guard let fetchedMapItem = try await locationService.fetchMapItems(for: searchString).first else { return }
            mapItem = fetchedMapItem
            loadingState = .success
        } catch {
            loadingState = .failed
        }
    }
    
    func fetchMapItems(for coordinate: CLLocationCoordinate2D?) async {
        loadingState = .loading
        isMapItemListPresented = true
        guard let coordinate else { return }
        do {
            guard let placemarkMapItem = try await locationService.fetchPlacemarkMapItem(for: coordinate) else { return }
            mapItems.append(placemarkMapItem)

            let pointOfInterestMapItems = try await locationService.fetchPointOfInterestMapItems(for: coordinate)
            mapItems.append(contentsOf: pointOfInterestMapItems)

            loadingState = .success
        } catch {
            logger.error("Error fetching map items: \(error.localizedDescription)")
            loadingState = .failed
        }
    }
    
    func saveLocation(mapItem: MKMapItem?) -> PersistentIdentifier? {
        if let mapItem {
            let newLocation = Location(mapItem: mapItem)
            modelContext.insert(newLocation)
            return newLocation.persistentModelID
        } else {
            return nil
        }
    }
    
    
    // MARK: - Old functions
    
    func fetchMapItem(for mapFeature: MapFeature) async -> MKMapItem? {
        let request = MKMapItemRequest(feature: mapFeature)
        var mapItem: MKMapItem? = nil
        do {
            mapItem = try await request.mapItem
            loadingState = .success
        } catch {
            logger.error("Getting map item from map feature failed: \(error.localizedDescription)")
            loadingState = .failed
        }
        return mapItem
    }
    
    func assignMapItem(for mapItem: MKMapItem) -> MKMapItem {
        loadingState = .success
        return mapItem
    }
    
    func fetchMapItem(for coordinate: CLLocationCoordinate2D) async -> MKMapItem? {
        var mapItem: MKMapItem? = nil
        logger.debug("Am i here")
        do {
//            if let fetchedMapItem = try await locationService.findNearestMapItem(at: coordinate) {
//            if let fetchedMapItem = try await locationService.fetchMapItems(for: coordinate).first {
            if let fetchedMapItem = try await locationService.createMapItem(for: coordinate) {
                logger.debug("or here")
                logger.debug("fetched map item func: \(fetchedMapItem)")
                mapItem = fetchedMapItem
                loadingState = .success
            } else {
                loadingState = .failed
            }
        } catch {
            loadingState = .failed
        }
        return mapItem
    }
}

#Preview(traits: .previewData) {
    let location = Step.stJohnsLane.location ?? Location(coordinate: Step.stJohnsLane.coordinate)
    let locationClosure: (PersistentIdentifier?) -> Void = { _ in }
    let placemark = MKPlacemark(coordinate: location.coordinate)
    let mapItem = MKMapItem(placemark: placemark)
    
    NavigationStack {
        EditLocationView(
            mapSelection: MapSelection(location.mapItem ?? mapItem),
            locationClosure: locationClosure
        )
    }
}
