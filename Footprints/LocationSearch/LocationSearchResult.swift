//
//  PlacemarkResult.swift
//  Footprints
//
//  Created by Jill Allan on 18/10/2024.
//

import MapKit
import SwiftUI

struct LocationSearchResult: View {
    @State var locationSuggestion: LocationSuggestion
    @State var mapItemSearchService = MapItemSearchService()
    @State var mapItem: MKMapItem?
    @State private var loadingState = LoadingState.loading
//    @Bindable var step: Step
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            VStack {
                switch loadingState {
                case .empty:
                    EmptyView()
                case .loading:
                    ProgressView()
                case .success:
                    Form {
                        Text(locationSuggestion.subtitle)
                        Text(mapItem?.name ?? "")
                        Text(mapItem?.placemark.title ?? "")
                        Text(mapItem?.placemark.subtitle ?? "")
                    }
                case .failed:
                    FailedView()
                }
            }
            .navigationTitle(locationSuggestion.title)
            .onAppear {
                Task {
                    mapItem = await fetchMapItem(for: locationSuggestion.mapItemSearchTerm)
                }
            }
        }
    }
    
    func fetchMapItem(for searchSuggestion: String) async -> MKMapItem? {
        do {
            mapItem = try await mapItemSearchService.search(
                for: locationSuggestion.mapItemSearchTerm,
                in: MKCoordinateRegion.defaultRegion()
            )
            loadingState = .success
            return mapItem
        } catch {
            print("Error fetching map item: \(error.localizedDescription)")
            loadingState = .failed
            return nil
        }
    }
}

//#Preview {
//    LocationSearchResult(
//        locationSuggestion: LocationSuggestion(
//        title: "London",
//        subtitle: "England"
//    ),
//        mapItem: .constant(MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 51.5072, longitude: 0.0)))), step: .atomium
//    )
//}
