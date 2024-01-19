//
//  SearchResultSheet.swift
//  Footprints
//
//  Created by Jill Allan on 19/01/2024.
//

import MapKit
import SwiftUI

struct SearchResultSheet: View {
    let mapItem: MKMapItem
    @Bindable var step: Step
    
    var body: some View {
        NavigationStack {
            VStack {
                Button("Select location", systemImage: "location") {
                    
                }
            }
            .navigationTitle(mapItem.placemark.title ?? "No Title")
        }
    }
}

#Preview {
    ModelPreview(SampleContainer.sample) {
        SearchResultSheet(mapItem: MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 51.5, longitude: 0.0))), step: Step.stJohnsLane)
    }
}
