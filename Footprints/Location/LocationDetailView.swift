//
//  LocationDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 15/11/2024.
//

import MapKit
import SwiftUI

struct LocationDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var currentLocation: CLLocationCoordinate2D
    @State var tappedLocation: Coordinate?
    @State var mapFeature: MapFeature?
    @State var selectedMapItem: MKMapItem?
    @State var location: Location?
    @State var mapCameraPosition: MapCameraPosition = .automatic
    @State private var isPlacemarkSheetPresented: Bool = false
    @State private var isMapItemSheetPresented: Bool = false
    @State private var isSearchSuggestionSheetPresented: Bool = false
    @State private var isMapItemSelected: Bool = false
    let mapItem: (MKMapItem?) -> Void

    @State private var selectedMap: MapType = .mapFeatures
    
    // MARK: - Search Properties
    @State private var locationSuggestionSearch = LocationSuggestionSearch()
    @State private var locationSuggestions: [LocationSuggestion] = []
    @State private var selectedLocationSuggestion: LocationSuggestion?
    @State private var searchQuery: String = ""
    
    var safeAreaInset: Double {
        if isPlacemarkSheetPresented || isMapItemSheetPresented {
            300
        } else {
            0
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                switch selectedMap {
                case .mapFeatures:
                    MapFeatureMap(
                        mapCameraPosition: $mapCameraPosition,
                        currentLocation: currentLocation,
                        mapFeature: $mapFeature
                    )
                case .anyLocation:
                    TappedLocationMap(
                        mapCameraPosition: $mapCameraPosition,
                        currentLocation: currentLocation,
                        tappedLocation: $tappedLocation
                    )
                }
            }
            .overlay(alignment: .top) {
                MapPicker(selectedMap: $selectedMap)
            }
            .safeAreaInset(edge: .bottom) {
                Color.clear
                    .frame(height: safeAreaInset)
            }
            .searchable(text: $searchQuery, prompt: "Search for a location")
            .searchSuggestions {
                ForEach(locationSuggestions) { suggestion in
                    Button {
                        selectedLocationSuggestion = suggestion
                    } label: {
                        LocationSuggestionRow(locationSuggestion: suggestion)
                    }
                    .buttonStyle(.plain)
                }
            }
            // MARK: Navigation
            .navigationTitle("Location Details")
            .toolbarBackground(.hidden, for: .navigationBar)
            
            // Is sheet(isPresented) used here instead of sheet(item) otherwise when the item changes the view is dismissed rather than updated
            .sheet(isPresented: $isPlacemarkSheetPresented) {
                if isMapItemSelected {
                    mapItem(selectedMapItem)
                    dismiss()
                }
            } content: {
                if let tappedLocation {
                    TappedLocationDetail(
                        coordinate: tappedLocation,
                        mapItem: $selectedMapItem,
                        isMapItemSelected: $isMapItemSelected
                    )
                    .mapDetailPresentationStyle()
                }
            }
            .sheet(isPresented: $isMapItemSheetPresented) {
                if isMapItemSelected {
                    mapItem(selectedMapItem)
                    dismiss()
                }
            } content: {
                if let mapFeature {
                    MapFeatureDetail(
                        mapFeature: mapFeature,
                        mapItem: $selectedMapItem,
                        isMapItemSelected: $isMapItemSelected
                    )
                    .mapDetailPresentationStyle()
                }
            }
            .sheet(isPresented: $isSearchSuggestionSheetPresented, onDismiss: {
                if isMapItemSelected {
                    mapItem(selectedMapItem)
                    dismiss()
                }
            }, content: {
                if let selectedLocationSuggestion {
                    SearchSuggestionDetail(
                        searchSuggestion: selectedLocationSuggestion,
                        mapItem: $selectedMapItem,
                        isMapItemSelected: $isMapItemSelected
                    )
                    .mapDetailPresentationStyle()
                }
            })

    
            // MARK: View Updates
            .onAppear {
                mapCameraPosition = MapCameraPosition.region(currentLocation.region)
            }
            .onChange(of: tappedLocation) {
                isPlacemarkSheetPresented = true
            }
            .onChange(of: mapFeature) {
                isMapItemSheetPresented = true
            }
            .onChange(of: selectedLocationSuggestion) {
                isSearchSuggestionSheetPresented = true
            }
            .onChange(of: selectedMap) {
                isMapItemSheetPresented = false
                isPlacemarkSheetPresented = false
                isSearchSuggestionSheetPresented = false
            }
            .onChange(of: searchQuery) {
                Task { await updateSearchResults() }
            }
        }
    }
    
    func updateSearchResults() async {
        let region = MKCoordinateRegion.defaultRegion()
        do {
            locationSuggestions = try await locationSuggestionSearch.fetchLocationSuggestions(for: searchQuery, in: region)
        } catch {
//             logger.error("Failed to fetch search results: \(error.localizedDescription)")
        }
    }
}

#Preview("London") {

    let coordinate = CLLocationCoordinate2D.defaultCoordinate()
    LocationDetailView(currentLocation: coordinate) { _ in
        
    }
}

#Preview("Bristol", traits: .previewData) {
    let coordinate = Step.bedminsterStation.coordinate
    LocationDetailView(currentLocation: coordinate) { _ in
        
    }
}
