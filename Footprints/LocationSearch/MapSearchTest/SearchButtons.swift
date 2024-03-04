//
//  SearchButtons.swift
//  Footprints
//
//  Created by Jill Allan on 23/02/2024.
//

import SwiftUI
import MapKit

struct SearchButtons: View {
    @State var region = MKCoordinateRegion()
    let coordinate: CLLocationCoordinate2D
    @Binding var searchResults: [MKMapItem]
    
    var body: some View {
        HStack {
            Button {
                search(for: "playgrounds")
            } label: {
                Label("Playgrounds", systemImage: "tree")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                search(for: "beachs")
            } label: {
                Label("Beaches", systemImage: "beach.umbrella")
            }
            .buttonStyle(.borderedProminent)
        }
        .labelStyle(.iconOnly)
        .onAppear {
            region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        }
    }
    
    func search(for query: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.region = region
        searchRequest.naturalLanguageQuery = query
        
        Task {
            let search = MKLocalSearch(request: searchRequest)
            let searchResponse = try? await search.start()
            searchResults = searchResponse?.mapItems ?? []
            print(searchResults)
        }
    }
}

#Preview {
    let coordinate = CLLocationCoordinate2D(latitude: 51.500685, longitude: -0.124570)
    let searchResults: [MKMapItem] = []
    
    return SearchButtons(coordinate: coordinate, searchResults: .constant(searchResults))
}
