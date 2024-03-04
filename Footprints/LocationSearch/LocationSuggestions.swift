//
//  LocationSearchResultsList.swift
//  Footprints
//
//  Created by Jill Allan on 26/01/2024.
//

import MapKit
import SwiftData
import SwiftUI

struct LocationSuggestions: View {
    @Query var locations: [Location]

    var body: some View {
        List {
            Section {
                ForEach(locations) { location in
                    RecentLocationRow(location: location)
                }
            } header: {
                Text("Recent Locations")
            }
            
            Section {
                // TODO: Log list of searches
            } header: {
                Text("Recent Searches")
            }
            
            Section {
                // TODO: Lookup nearby landmarks
            } header: {
                Text("Nearby")
            }
        }
        
        .navigationTitle("Location Search")
    }
}

#Preview {
    LocationSuggestions()
        .modelContainer(SampleContainer.sample())
}
