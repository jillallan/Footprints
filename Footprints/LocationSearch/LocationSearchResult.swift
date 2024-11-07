//
//  PlacemarkResult.swift
//  Footprints
//
//  Created by Jill Allan on 18/10/2024.
//

import MapKit
import SwiftUI

struct LocationSearchResult: View {
    @Environment(\.dismiss) var dismiss
    var dismissSearch: DismissSearchAction
    @State private var loadingState = LoadingState.loading
    @State private var locationService = LocationService()
    @State var locationSuggestion: LocationSuggestion
    @Binding var mapItem: MKMapItem?
    
    var body: some View {
        NavigationStack {
            VStack {
                switch loadingState {
                case .empty:
                    EmptyView()
                case .loading:
                    ProgressView()
                case .success:
                    if let mapItem {
                        MapItemSuccessView(mapItem: mapItem)
                    }
                    
//                    Form {
//                        Text(locationSuggestion.subtitle)
//                        Text(mapItem?.name ?? "")
//                        Text(mapItem?.placemark.title ?? "")
//                        Text(mapItem?.placemark.subtitle ?? "")
//                    }
                case .failed:
                    FailedView()
                }
                
            }
            .navigationTitle(locationSuggestion.title)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Select") {
                        dismiss()
                        dismissSearch()
                    }
                    .disabled(mapItem == nil)
                }
            }
            .onAppear {
                Task {
                    mapItem = await fetchMapItem(for: locationSuggestion.mapItemSearchTerm)
                }
            }
        }
    }
    
    func fetchMapItem(for searchSuggestion: String) async -> MKMapItem? {
        var mapItem: MKMapItem? = nil
        do {
            if let mapItem = try await locationService.fetchMapItems(for: searchSuggestion).first {
                loadingState = .success
            } else {
                loadingState = .failed
            }
        } catch {
            loadingState = .failed
        }
        return mapItem
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
