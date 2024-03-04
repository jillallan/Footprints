//
//  SearchTest.swift
//  Footprints
//
//  Created by Jill Allan on 16/02/2024.
//

import SwiftUI
import MapKit

struct LocationSearchView2: View {
    //    @Environment(MapSearchService.self) private var mapSearchService
    @State var mapSearchService = MapSearchService()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.isSearching) private var isSearching
    @State private var position: MapCameraPosition = .automatic
    @State var dismissSearchView: Bool = false
    @State var navPath = NavigationPath()
    @State var searchQuery: String = ""
    @State var searchResult: MKMapItem?
    @Binding var isSearchPresented: Bool
    @Bindable var step: Step
    
    var body: some View {
        
        LocationSuggestions()
        
            .border(Color.blue)
            .searchable(
                text: $searchQuery,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search for a location"
            )
            .searchSuggestions {
                ForEach(mapSearchService.searchResults, id: \.self) { mapItem in
                    NavigationLink(value: mapItem) {
                        //                                Text(mapItem.name ?? "No name")
//                        LocationSearchSuggestionRow(dismissSearchView: $dismissSearchView, step: step, mapItem: mapItem)
                    }
                    .buttonStyle(.plain)
                }
            }
            .onChange(of: searchQuery, debounceTime: 0.2) { searchQuery in
                Task {
                    await mapSearchService.search(
                        for: searchQuery,
                        in: step.region
                    )
                }
            }
//            .sheet(isPresented: $isSearchPresented) {
//                
//            } content: {
//                
//                VStack{
//                    ForEach(mapSearchService.searchResults, id: \.self) { mapItem in
//                        NavigationLink(value: mapItem) {
//                            //                                Text(mapItem.name ?? "No name")
//                            LocationSearchSuggestionRow(dismissSearchView: $dismissSearchView, step: step, mapItem: mapItem)
//                        }
//                        .buttonStyle(.plain)
//                    }
//                }
//                .presentationDetents([.medium])
//                .presentationBackgroundInteraction(.enabled)
//            
////                .searchPresentationToolbarBehavior(.avoidHidingContent)
//            }
    }
}

#Preview {
    ModelPreview(SampleContainer.sample) {
        LocationSearchView2(mapSearchService: MapSearchService.preview, isSearchPresented: .constant(true), step: Step.stJohnsLane)
        //            .environment(MapSearchService.preview)
    }
}

