//
//  EditStepForm.swift
//  Footprints
//
//  Created by Jill Allan on 06/10/2024.
//

import MapKit
import SwiftUI

struct EmptyNameView: View {
    var body: some View {
        Text("New Step")
    }
}

struct SuccessView: View {
//    let placemarkName: String
    
    var body: some View {
        Text("Hello")
    }
}


struct EditStepForm: View {
    @State var loadingState: LoadingState
    @State var placemarkName: String
    @State var date: Date
    @State private var searchQuery: String = ""
    @State private var locationSuggestionSearch = LocationSuggestionSearch()
    @State private var locationSuggestions: [LocationSuggestion] = []
    @State private var selectedLocationSuggestion: LocationSuggestion?
    @Binding var mapItem: MKMapItem?
    @Bindable var step: Step
    
    var body: some View {
        NavigationStack {
            Form {
                
                switch loadingState {
                case .empty:
                    EmptyNameView()
                case .loading:
                    LoadingView()
                case .success:
                    SuccessView()
                case .failed:
                    FailedView()
                }
                DatePicker("Step Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
            }
            .searchable(text: $searchQuery)
            .searchSuggestions {
                ForEach(locationSuggestions) { suggestion in
                    Button {
                        selectedLocationSuggestion = suggestion
                    } label: {
                        LocationSuggestionRow(locationSuggestion: suggestion)
                    }
                    .buttonStyle(.plain)
                }
            }
            .onChange(of: searchQuery) {
                Task {
                    await updateSearchResults()
                }
            }
            .sheet(item: $selectedLocationSuggestion) {
                
            } content: { locationSuggestion in
//                LocationSearchResult(locationSuggestion: locationSuggestion, mapItem: $mapItem, step: step)
//                    .presentationDetents([.height(400)])
                    
            }
        }
        .presentationBackgroundInteraction(.enabled(upThrough: .large))
    }
    
    func updateSearchResults() async {
        do {
            locationSuggestions = try await locationSuggestionSearch.fetchLocationSuggestions(for: searchQuery)
        } catch {
//            logger.error("Failed to fetch search results: \(error.localizedDescription)")
        }
    }
}
    
#Preview {
    EditStepForm(
        loadingState: .success,
        placemarkName: "Placemark name",
        date: Date.now,
        mapItem: .constant(
            MKMapItem(
                placemark: MKPlacemark(
                    coordinate: CLLocationCoordinate2D(latitude: 51.5072, longitude: 0.0)
                )
            )
        ), step: .atomium
    )
}
