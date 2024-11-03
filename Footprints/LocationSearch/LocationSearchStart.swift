//
//  LocationSearchStart.swift
//  Footprints
//
//  Created by Jill Allan on 02/11/2024.
//

import MapKit
import SwiftUI

struct LocationSearchStart: View {
    @Environment(\.isSearching) private var isSearching
    @Environment(\.dismissSearch) private var dismissSearch
    @Binding var selectedLocationSuggestion: LocationSuggestion?
//    @State var mapItem: MKMapItem?
    let mapItemClosure: (MKMapItem) -> Void
    
    var body: some View {
        Form {
            Text("Hello, World!")
        }
        .sheet(item: $selectedLocationSuggestion) {
            
        } content: { locationSuggestion in
            LocationSearchResult(dismissSearch: dismissSearch, locationSuggestion: locationSuggestion) { item in
                mapItemClosure(item)
            }
            .presentationDetents([.height(400)])
            
        }
    }
}

//#Preview {
//    LocationSearchStart()
//}
