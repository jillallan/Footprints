//
//  LocationSearchSuggestionRow.swift
//  Footprints
//
//  Created by Jill Allan on 19/01/2024.
//

import MapKit
import SwiftUI

struct LocationSearchSuggestionRow: View {
    let mapItem: MKMapItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(mapItem.placemark.title ?? "No title")
                .font(.headline)
            Text(mapItem.placemark.subtitle ?? "No subtitle")
                .font(.subheadline)
        }
    }
}

#Preview {
    LocationSearchSuggestionRow(mapItem: MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 51.5, longitude: 0.0))))
}
