//
//  SearchMap.swift
//  Footprints
//
//  Created by Jill Allan on 23/02/2024.
//

import MapKit
import SwiftUI

struct SearchMap: View {
    let coordinate = CLLocationCoordinate2D(latitude: 51.503347, longitude: -0.079396)
    @State private var stepPosition: MapCameraPosition = .region(MKCoordinateRegion())
    @State private var searchResults: [MKMapItem] = []
    
    var body: some View {
        VStack {
            Map(position: $stepPosition) {
                Marker("london", coordinate: coordinate)
                ForEach(searchResults) { result in
                    Marker(item: result)
                }
            }
            SearchButtons(coordinate: coordinate, searchResults: $searchResults)
        }
        .onAppear {
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.513471, longitude: -0.171232), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            stepPosition = .region(region)
            
        }
    }
}

#Preview {
    SearchMap()
}
