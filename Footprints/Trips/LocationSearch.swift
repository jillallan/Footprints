//
//  LocationSearch.swift
//  Footprints
//
//  Created by Jill Allan on 19/01/2024.
//

import MapKit
import SwiftUI

struct LocationSearch: View {
    var mapSearchService = MapSearchService()
    @State var region: MKCoordinateRegion
    @State var searchQuery: String = ""
    @State var searchResult: MKMapItem?
    @Bindable var step: Step
    @Binding var searchDetent: PresentationDetent
    @State var isSearchResultPresented: Bool = false
    
    var body: some View {
        VStack {
            NavigationStack {
                ScrollView {

                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Location Search")
                .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for a location")
                .searchSuggestions {
                    ForEach(mapSearchService.searchResults) { mapItem in
                        LocationSearchSuggestionRow(mapItem: mapItem)
                            .onTapGesture {
                                searchResult = mapItem
                            }
                    }
                }
                .onChange(of: searchQuery) {
                    print("search query changed")
                    Task {
                        await mapSearchService.search(for: searchQuery, in: region)
                    }
                }
                .onSubmit(of: .search) {
                    print("Search submitted")
                    searchDetent = .medium
                    isSearchResultPresented.toggle()
                }
                .sheet(isPresented: $isSearchResultPresented) {
                    Text("placeholder")
                        .presentationDetents([searchDetent])
                }
                .sheet(item: $searchResult) {
                    // TODO: on dismiss
                } content: { searchResult in
                    SearchResultSheet(mapItem: searchResult, step: step)
                        .presentationDetents([.medium])
                }

            }
        }
    }
}

#Preview {
    ModelPreview(SampleContainer.sample) {
        LocationSearch(region: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.5, longitude: 0.0),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        ), step: Step.stJohnsLane, searchDetent: .constant(PresentationDetent.large))
    }
}
