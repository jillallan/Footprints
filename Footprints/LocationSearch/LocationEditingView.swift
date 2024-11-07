//
//  StepEditView.swift
//  Footprints
//
//  Created by Jill Allan on 02/11/2024.
//

import MapKit
import SwiftData
import SwiftUI

struct LocationEditingView: View {
    @Environment(\.dismiss) var dismiss
    let mapRegion: MapCameraPosition
    @State private var searchQuery: String = ""
    @State private var locationSuggestionSearch = LocationSuggestionSearch()
    @State private var locationSuggestions: [LocationSuggestion] = []
    @State private var selectedLocationSuggestion: LocationSuggestion?
    @State var mapItem: MKMapItem?
    let mapItemClosure: (MKMapItem) -> Void
    
    var body: some View {
        NavigationStack {
            LocationEditingMap(
                mapRegion: mapRegion,
                selectedLocationSuggestion: $selectedLocationSuggestion,
                mapItem: $mapItem
            )
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
                    if let mapItem {
                        mapItemClosure(mapItem)
                    }
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

#Preview {
    let mapItemClosure: (MKMapItem) -> Void = { _ in }
    LocationEditingView(
        mapRegion: MapCameraPosition.region(Step.bedminsterStation.region),
        mapItemClosure: mapItemClosure
    )
}
