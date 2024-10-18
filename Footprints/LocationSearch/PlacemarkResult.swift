//
//  PlacemarkResult.swift
//  Footprints
//
//  Created by Jill Allan on 18/10/2024.
//

import MapKit
import SwiftUI

struct PlacemarkResult: View {
    @State var locationSuggestion: LocationSuggestion
    @State var mapItemSearchService = MapItemSearchService()
    @Binding var mapItem: MKMapItem?
    @State private var loadingState = LoadingState.loading
    
    
    var body: some View {
        VStack {
            switch loadingState {
            case .empty:
                EmptyView()
            case .loading:
                ProgressView()
            case .success:
                Form {
                    Text(mapItem?.name ?? "")
                    Text(mapItem?.placemark.title ?? "")
                }
            case .failed:
                FailedView()
            }
            Text(locationSuggestion.title)
        }
        .navigationTitle(locationSuggestion.title)
        .onAppear {
            Task {
                do {
                    mapItem = try await mapItemSearchService.search(
                        for: locationSuggestion.mapItemSearchTerm,
                        in: MKCoordinateRegion.defaultRegion()
                    )
                    loadingState = .success
                } catch {
                    print("Error fetching map item: \(error.localizedDescription)")
                    loadingState = .failed
                }
                
            }
        }
    }
}

#Preview {
    PlacemarkResult(
        locationSuggestion: LocationSuggestion(
        title: "London",
        subtitle: "England"
    ),
        mapItem: .constant(MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 51.5072, longitude: 0.0))))
    )
}
