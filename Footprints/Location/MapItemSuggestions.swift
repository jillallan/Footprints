//
//  MapItemSuggestions.swift
//  Footprints
//
//  Created by Jill Allan on 13/11/2024.
//

import MapKit
import SwiftUI

struct MapItemSuggestions: View {
    @Binding var loadingState: LoadingState
    @Binding var mapItems: [MKMapItem]
    
    var body: some View {
        NavigationStack {
            VStack {
                switch loadingState {
                case .loading: LoadingView(message: "Fetching locations...")
                case .success: MapItemSuggestionsSuccess(mapItems: $mapItems)
                case .failed: FailedView(errorMessage: "Failed")
                }
            }
            .navigationTitle("Suggested Locations")
        }
    }
}

#Preview {
    let mapItems = [
        MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 51.371435, longitude: -2.547213))),
        MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 51.32, longitude: -2.55))),
        MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 51.33, longitude: -2.56))),
        MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 51.34, longitude: -2.57)))
    ]
    MapItemSuggestions(loadingState: .constant(.success), mapItems: .constant(mapItems))
}
