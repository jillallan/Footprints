//
//  SearchView.swift
//  Footprints
//
//  Created by Jill Allan on 30/01/2024.
//

import SwiftUI
import MapKit

struct LocationSearchView: View {

    // MARK: - Search query properties
    @State var searchQuery: String = ""
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.isSearching) private var isSearching
    @State var dismissSearchView: Bool = false
    
    let coordinate: CLLocationCoordinate2D
    // Change region to update based on last search.  e.g. if a search for italy then coffee the local area would be italy
    let region: MKCoordinateRegion
    @Binding var searchResults: [MKMapItem]
    @State var searchResult: MKMapItem?
    @State var resultClosure: (MKMapItem) -> ()
    let localSearchCompleter = LocalSearchCompleter()
    
    var body: some View {
        VStack {
            NavigationStack {
                LocationSuggestions()
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
                        LocalSearchCompleterResults(
                            results: localSearchCompleter.completions,
                            region: region,
                            searchResults: $searchResults
//                            resultClosure: $resultClosure
                        )
                    }
                    .navigationDestination(for: MKMapItem.self) { mapItem in
                        LocationSearchResult(result: mapItem)
                    }
                    .navigationDestination(item: $searchResult) { mapItem in
                        LocationSearchResult(result: mapItem)
                    }
                    .onChange(of: searchQuery, debounceTime: 0.5) { searchQuery in
                        Task {
//                            search(for: searchQuery)
                            search2(for: searchQuery)
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
    }
    func search(for query: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.region = region
        searchRequest.naturalLanguageQuery = query
        
        Task {
            let search = MKLocalSearch(request: searchRequest)
            let searchResponse = try? await search.start()
            searchResults = searchResponse?.mapItems ?? []
            print(searchResults)
        }
    }
    
    func search2(for query: String) {
        localSearchCompleter.search(for: query, in: region)
    }
}

struct LocationSearchView_Preview: PreviewProvider {
    static var previews: some View {
        let coordinate = CLLocationCoordinate2D(latitude: 51.500685, longitude: -0.124570)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 0.1, longitudinalMeters: 0.1)
        let results: [MKMapItem] = []
        
        NavigationStack {
            VStack {
                
            }

            .sheet(isPresented: .constant(true)) {
                LocationSearchView(coordinate: coordinate, region: region, searchResults: .constant(results)) { _ in }
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.small, .medium, .large], selection: .constant(.medium))
                    .presentationBackgroundInteraction(.enabled(upThrough: .medium))
                    .interactiveDismissDisabled()
            }
        }
    }
}
