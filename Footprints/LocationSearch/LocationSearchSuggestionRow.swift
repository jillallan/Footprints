//
//  LocationSearchSuggestionRow.swift
//  Footprints
//
//  Created by Jill Allan on 17/03/2024.
//

import MapKit
import SwiftUI

struct LocationSearchSuggestionRow: View {
    @Environment(\.dismissSearch) private var dismissSearch
    
    // MARK: - Data Properties
    let searchSuggestion: SearchCompletions
    @Binding var searchResults: [MKMapItem]
    @Binding var searchResult: MKMapItem?
    
    // MARK: - Search Properties
    let region: MKCoordinateRegion
    let mapSearchService = MapSearchService()
    
    
    var body: some View {
        Button {
            if searchSuggestion.subTitle == "Search Nearby" {
                Task {
                    searchResults = await mapSearchService.search(
                        for: searchSuggestion.title,
                        in: region
                    )
                    dismissSearch()
                }
                
            } else {
                Task {
                    if let result = await mapSearchService.search(
                        for: searchSuggestion.title + searchSuggestion.subTitle,
                        in: region
                    ).first {
                        searchResults = [result]
                    }
                    dismissSearch()
                }
            }
        } label: {
            VStack(alignment: .leading) {
                Text(searchSuggestion.title)
                Text(searchSuggestion.subTitle)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    LocationSearchSuggestionRow(
        searchSuggestion: MapSearchService.completions.first!,
        searchResults: .constant([]), searchResult: .constant(nil),
        region: MKCoordinateRegion.example
    )
}
