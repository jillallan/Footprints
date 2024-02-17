//
//  LocationSearchResultsList.swift
//  Footprints
//
//  Created by Jill Allan on 26/01/2024.
//

import MapKit
import SwiftData
import SwiftUI

struct LocationSearchResultsList: View {
    @Query var locations: [Location]

    var body: some View {
        LazyVStack {
            Section {
                ForEach(locations) { location in
                    Text(location.name ?? "No location details")
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

//#Preview {
//    LocationSearchResultsList()
//}
