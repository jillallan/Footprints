//
//  LocationSearchSheet.swift
//  Footprints
//
//  Created by Jill Allan on 01/11/2024.
//

import SwiftUI

struct LocationSearchSheet: View {
    @State private var searchQuery: String = ""
    @State private var locationSuggestionSearch = LocationSuggestionSearch()
    @State private var locationSuggestions: [LocationSuggestion] = []
    @State private var selectedLocationSuggestion: LocationSuggestion?
    @State var loadingState: LoadingState = .empty
    
    
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
//                DatePicker("Step Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
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
                LocationSearchResult(
                    locationSuggestion: locationSuggestion //,
//                    mapItem: $mapItem,
//                    step: step
                )
                .presentationDetents([.height(400)])
                    
            }
        }
    }
    
    func updateSearchResults() async {
        do {
            locationSuggestions = try await locationSuggestionSearch.fetchLocationSuggestions(for: searchQuery)
        } catch {
//            logger.error("Failed to fetch search results: \(error.localizedDescription)")
        }
    }
}

//#Preview {
//    LocationSearchSheet()
//}
