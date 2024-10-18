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
    @Bindable var step: Step
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
                    do {
                        mapItem = try await mapItemSearchService.search(
                            for: locationSuggestion.mapItemSearchTerm,
                            in: MKCoordinateRegion.defaultRegion()
                        )
                        //                    if let mapItemPlacemark = mapItem?.placemark {
                        //                        let placemark = Placemark(
                        //                            title: locationSuggestion.title,
                        //                            subtitle: locationSuggestion.subtitle,
                        //                            placemark: mapItemPlacemark)
                        //                        modelContext.insert(placemark)
                        //                        placemark.steps.append(step)
                        //                    }
                        
                        loadingState = .success
                    } catch {
                        print("Error fetching map item: \(error.localizedDescription)")
                        loadingState = .failed
                    }
                    
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
        mapItem: .constant(MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 51.5072, longitude: 0.0)))), step: .atomium
    )
}
