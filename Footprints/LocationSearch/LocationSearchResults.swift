//
//  LocationSearchResults.swift
//  Footprints
//
//  Created by Jill Allan on 23/02/2024.
//

import MapKit
import SwiftUI

struct LocationSearchResults: View {
    @Binding var dismissSearchView: Bool
    let searchResults: [MKMapItem]
    let region: MKCoordinateRegion
    @Binding var resultClosure: (MKMapItem) -> ()
    
    var body: some View {
        ForEach(searchResults, id: \.self) { mapItem in
            NavigationLink(value: mapItem) {
                LocationSearchResultRow(mapItem: mapItem, dismissSearchView: $dismissSearchView, resultClosure: $resultClosure)
            }
            .buttonStyle(.plain)
        }
    }
}

//#Preview {
//    LocationSearchResults()
//}
