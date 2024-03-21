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
    let region: MKCoordinateRegion
    @Binding var searchResults: [MKMapItem]
    @Binding var searchResult: MKMapItem?
    @State var resultClosure: (MKMapItem) -> ()
    @State var isSearchItemListPresented: Bool = false
    
    let localSearchCompleter = MapSearchService()
    
    
    
    var body: some View {
        VStack {
            NavigationStack {
                LocationSuggestions(
                    searchResults: $searchResults,
                    searchResult: $searchResult
                ) { mapItem in
                    resultClosure(mapItem)
                    dismiss()
                }
#if os(iOS)
                    .navigationBarTitleDisplayMode(.inline)
                    .searchable(
                        text: $searchQuery,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Search for a location"
                    )
#else
                    .searchable(
                        text: $searchQuery,
                        prompt: "Search for a location"
                    )
#endif
                    .searchSuggestions {
                        ForEach(localSearchCompleter.completions) { searchSuggestion in
                            LocationSearchSuggestionRow(
                                searchSuggestion: searchSuggestion,
                                searchResults: $searchResults, 
                                searchResult: $searchResult,
                                region: region
                            )
                        }
                    }
//                    .navigationDestination(for: MKMapItem.self) { mapItem in
//                        LocationSearchResult2(result: mapItem)
//                    }
                    

                    .onChange(of: searchQuery, debounceTime: 0.5) { searchQuery in
                        Task {
                            localSearchCompleter.search(for: searchQuery, in: region)
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
}

struct LocationSearchView_Preview: PreviewProvider {
    static var previews: some View {
        
        NavigationStack {
            VStack {
                
            }
            
            .sheet(isPresented: .constant(true)) {
                LocationSearchView(
                    coordinate: CLLocationCoordinate2D.example,
                    region: MKCoordinateRegion.example,
                    searchResults: .constant([]), 
                    searchResult: .constant(nil)) { _ in }
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.small, .medium, .large], selection: .constant(.medium))
                    .presentationBackgroundInteraction(.enabled(upThrough: .medium))
                    .interactiveDismissDisabled()
            }
        }
    }
}
