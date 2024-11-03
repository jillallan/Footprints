//
//  StepEditView.swift
//  Footprints
//
//  Created by Jill Allan on 02/11/2024.
//

import MapKit
import SwiftData
import SwiftUI

struct LocationEditingView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var step: Step
    @State private var searchQuery: String = ""
    @State private var locationSuggestionSearch = LocationSuggestionSearch()
    @State private var locationSuggestions: [LocationSuggestion] = []
    @State private var selectedLocationSuggestion: LocationSuggestion?
    let mapItemClosure: (MKMapItem) -> Void
    
    var body: some View {
        NavigationStack {
            LocationEditingMap(step: step, selectedLocationSuggestion: $selectedLocationSuggestion) { item in
                mapItemClosure(item)
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
            .navigationTitle(step.stepTitle)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
            .onChange(of: searchQuery) {
                Task {
                    await updateSearchResults()
                }
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

#Preview {
    let mapItemClosure: (MKMapItem) -> Void = { _ in }
    LocationEditingView(step: .bedminsterStation, mapItemClosure: mapItemClosure)
}
