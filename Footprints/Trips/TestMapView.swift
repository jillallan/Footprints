//
//  TestMapView.swift
//  Footprints
//
//  Created by Jill Allan on 28/01/2024.
//

import MapKit
import SwiftUI

struct TestMapView: View {
    @State private var selectedItem: MKMapItem?
    @State private var searchResults: [MKMapItem] = []
    @State private var searchQuery: String = ""
    
    var body: some View {
        VStack {
            Button("Search") {
                search(for: searchQuery)
            }
            
            TextField("Search", text: $searchQuery)
            
            Map(selection: $selectedItem) {
                ForEach(searchResults) { result in
                    Marker(item: result)
                }
            }
        }
    }
    
    func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.43, longitude: -2.54),
            span: MKCoordinateSpan (latitudeDelta: 0.0125, longitudeDelta: 0.0125)
            )

        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }
}

#Preview {
    TestMapView()
}
