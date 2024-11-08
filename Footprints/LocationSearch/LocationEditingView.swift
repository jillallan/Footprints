//
//  StepEditView.swift
//  Footprints
//
//  Created by Jill Allan on 02/11/2024.
//

import MapKit
import OSLog
import SwiftData
import SwiftUI

struct LocationEditingView: View {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: LocationEditingView.self)
    )
    
    @Environment(\.dismiss) var dismiss
    @State var location: Location
//    @Bindable var step: Step
    @State var mapRegion: MapCameraPosition
    @State var mapItem: MKMapItem
    @State private var searchQuery: String = ""
    @State private var locationSuggestionSearch = LocationSuggestionSearch()
    @State private var locationSuggestions: [LocationSuggestion] = []
    @State private var selectedLocationSuggestion: LocationSuggestion?
    
    var body: some View {
        let _ = logger.info("mapItem edit view: \(mapItem.debugDescription)")
        
        NavigationStack {
            Map()
//            LocationEditingMap(
//                step: step,
//                mapRegion: mapRegion,
//                mapItem: $mapItem,
//                dismiss: dismiss,
//                selectedLocationSuggestion: $selectedLocationSuggestion
//            )
            .searchable(text: $searchQuery)
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
            .navigationTitle("Edit Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
            .onChange(of: searchQuery) {
                Task {
                    await updateSearchResults()
                }
            }
        }
    }
    
    func updateSearchResults() async {
        do {
            locationSuggestions = try await locationSuggestionSearch.fetchLocationSuggestions(for: searchQuery)
        } catch {
            //            logger.error("Failed to fetch search results: \(error.localizedDescription)")
        }
    }
    
}

//#Preview {
//    let mapItemClosure: (MKMapItem) -> Void = { _ in }
//    let placemark = MKPlacemark(coordinate: Step.brusselsMidi.coordinate)
//    let mapItem = MKMapItem(placemark: placemark)
//   
//}
