//
//  StrepEditMap.swift
//  Footprints
//
//  Created by Jill Allan on 02/11/2024.
//

import MapKit
import SwiftUI

struct LocationEditingMap: View {
    @Bindable var step: Step
    @State private var mapRegion = MapCameraPosition.automatic
    @Environment(\.isSearching) private var isSearching
    @Environment(\.dismissSearch) private var dismissSearch
    @Binding var selectedLocationSuggestion: LocationSuggestion?
    let mapItemClosure: (MKMapItem) -> Void
    
    var body: some View {
        Map(position: $mapRegion)
            
            .sheet(item: $selectedLocationSuggestion) {
                
            } content: { locationSuggestion in
                LocationSearchResult(
                    dismissSearch: dismissSearch,
                    locationSuggestion: locationSuggestion
                ) { item in
                    mapItemClosure(item)
                }
                .presentationDetents([.height(400)])
                
            }
            .onChange(of: selectedLocationSuggestion) {
                dismissSearch()
            }
            .onAppear {
                mapRegion = .region(step.region)
            }
    }
}

//#Preview {
//    StrepEditMap()
//}
