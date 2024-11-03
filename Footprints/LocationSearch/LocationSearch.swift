//
//  LocationSearchSheet.swift
//  Footprints
//
//  Created by Jill Allan on 01/11/2024.
//

import MapKit
import OSLog
import SwiftUI

struct LocationSearch: View {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: LocationService.self))
    
    @Environment(\.dismiss) var dismiss
    @State private var searchQuery: String = ""
    @State private var locationSuggestionSearch = LocationSuggestionSearch()
    @State private var locationSuggestions: [LocationSuggestion] = []
    @State private var selectedLocationSuggestion: LocationSuggestion?
    @State private var mapItem: MKMapItem?
    let mapItemClosure: (MKMapItem) -> Void
    
    var body: some View {
        NavigationStack {
            LocationSearchStart(selectedLocationSuggestion: $selectedLocationSuggestion) { item in
                mapItemClosure(item)
                mapItem = item
            }
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
            .onChange(of: searchQuery) {
                Task {
                    await updateSearchResults()
                }
            }
            .toolbar {
                Button("Dismiss") {
                    dismiss()
                }
            }
//            .onChange(of: mapItem) {
//                dismiss()
//            }
        }
    }
    
    func updateSearchResults() async {
        do {
            locationSuggestions = try await locationSuggestionSearch.fetchLocationSuggestions(for: searchQuery)
        } catch {
            logger.error("Failed to fetch search results: \(error.localizedDescription)")
        }
    }
}

#Preview {
    let mapItemClosure: (MKMapItem) -> Void = { _ in }
    LocationSearch(mapItemClosure: mapItemClosure)
}
