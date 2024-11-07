//
//  StrepEditMap.swift
//  Footprints
//
//  Created by Jill Allan on 02/11/2024.
//

import MapKit
import OSLog
import SwiftUI

struct LocationEditingMap: View {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: LocationEditingMap.self)
    )
    
    let mapRegion: MapCameraPosition
    @Environment(\.isSearching) private var isSearching
    @Environment(\.dismissSearch) private var dismissSearch
    let mapItemIdentifier: String
    @Binding var selectedLocationSuggestion: LocationSuggestion?
    @State private var locationService = LocationService()
    @State private var selectedMapFeature: MapFeature?
    @State private var isLocationSuggestionViewPresented: Bool = false
    @State private var isMapFeatureViewPresented: Bool = false
    @Binding var mapItem: MKMapItem?
    
    var body: some View {
        let _ = logger.info("selectedMapFeature: \(selectedMapFeature.debugDescription)")
        
        Map(initialPosition: mapRegion, selection: $selectedMapFeature) {
            if let mapItem {
                Marker(item: mapItem)
                    
            }
        }
        
        .safeAreaInset(edge: .bottom) {
            if selectedMapFeature != nil {
                Color(.clear)
                    .frame(height: 400)
            }
        }
        .sheet(item: $selectedLocationSuggestion) { locationSuggestion in
            LocationSearchResult(
                dismissSearch: dismissSearch,
                locationSuggestion: locationSuggestion,
                mapItem: $mapItem
            )
            .presentationDetents([.medium])
            .presentationBackgroundInteraction(.enabled(upThrough: .medium))
            .presentationDragIndicator(.visible)
            
        }
        .sheet(isPresented: $isMapFeatureViewPresented) {
            if let selectedMapFeature {
                MapFeatureDetail(mapFeature: selectedMapFeature)
                    .presentationDetents([.medium])
                    .presentationBackgroundInteraction(.enabled(upThrough: .medium))
                    .presentationDragIndicator(.visible)
            }
        }
        .onChange(of: selectedMapFeature) {
            isMapFeatureViewPresented = true
        }
        .onChange(of: selectedLocationSuggestion) {
            dismissSearch()
        }
    }
}

//#Preview {
//    let mapCameraRegion = MapCameraPosition.region(Step.bedminsterStation.region)
//    let mapItemClosure: (MKMapItem) -> Void = { _ in }
//    let locationSuggestion = LocationSuggestion(title: "Bristol", subtitle: "England")
//    LocationEditingMap(
//        mapRegion: mapCameraRegion,
//        selectedLocationSuggestion: .constant(locationSuggestion),
//        mapItemClosure: mapItemClosure
//    )
//}


extension MapFeature: @retroactive Identifiable {
    public var id: UUID {
        UUID()
    }
}
