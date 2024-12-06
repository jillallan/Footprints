//
//  MapItemSuggestionsSuccess.swift
//  Footprints
//
//  Created by Jill Allan on 14/11/2024.
//

import MapKit
import SwiftUI

struct MapItemSuggestionsSuccess: View {
    @Binding var mapItems: [MKMapItem]
    
    var body: some View {
        List(mapItems, id: \.self) { mapItem in
            Text((mapItem.name ?? mapItem.placemark.title) ?? "Unknown Location")
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
    MapItemSuggestionsSuccess(mapItems: .constant(mapItems))
}
