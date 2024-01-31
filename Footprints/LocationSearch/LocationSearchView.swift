//
//  SearchView.swift
//  Footprints
//
//  Created by Jill Allan on 30/01/2024.
//

import SwiftUI
import MapKit

struct LocationSearchView: View {
    @Environment(MapSearchService.self) private var mapSearchService
    @Environment(\.dismiss) private var dismiss
    @Environment(\.isSearching) private var isSearching
    @State private var position: MapCameraPosition = .automatic
    @State var dismissSearchView: Bool = false
    @State var navPath = NavigationPath()
    @State var searchQuery: String = ""
    @State var searchResult: MKMapItem?
    @Bindable var step: Step
    
    var body: some View {
        VStack {
            Map(position: $position, selection: $searchResult) {
                Marker("", coordinate: step.coordinate)
                
                ForEach(mapSearchService.searchResults, id: \.self) { result in
                    Marker(item: result)
                }
            }
            NavigationStack(path: $navPath) {
                LocationSearchResultsList()

#if os(iOS)
                    .navigationBarTitleDisplayMode(.inline)
                    .searchable(
                        text: $searchQuery,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Search for a location"
                    )
#endif
                    .searchable(
                        text: $searchQuery,
                        prompt: "Search for a location"
                    )
                    .searchSuggestions {
                        ForEach(mapSearchService.searchResults, id: \.self) { mapItem in
                            NavigationLink(value: mapItem) {
//                                Text(mapItem.name ?? "No name")
                                LocationSearchSuggestionRow(dismissSearchView: $dismissSearchView, step: step, mapItem: mapItem)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .navigationDestination(for: MKMapItem.self) { mapItem in
                        LocationSearchResult(result: mapItem)
                    }
                    .navigationDestination(item: $searchResult) { mapItem in
                        LocationSearchResult(result: mapItem)
                    }
//                    .onChange(of: searchQuery) {
//                        Task {
//                            await mapSearchService.search(
//                                for: searchQuery,
//                                in: step.region
//                            )
//                        }
//                    }
                    .onChange(of: searchQuery, debounceTime: 0.3) { searchQuery in
                        Task {
                            await mapSearchService.search(
                                for: searchQuery,
                                in: step.region
                            )
                        }
                    }
                    .onChange(of: isSearching) {
                        print("search dismissed")
                        dismiss()
                    }
                    .onChange(of: dismissSearchView) {
                        dismiss()
                    }
                

            }
        }
        .onAppear {
            if step.placemark != nil {
                position = .item(step.mapItem)
            } else {
                position = .userLocation(fallback: .automatic)
            }
            
        }
        .onChange(of: mapSearchService.searchResults) {
            position = .automatic
            
        }
    }
}

#Preview {
    ModelPreview(SampleContainer.sample) {
        LocationSearchView(step: Step.stJohnsLane)
            .environment(MapSearchService.preview)
    }
}
