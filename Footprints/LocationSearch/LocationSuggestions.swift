//
//  LocationSearchResultsList.swift
//  Footprints
//
//  Created by Jill Allan on 26/01/2024.
//

import MapKit
import SwiftData
import SwiftUI

struct LocationSuggestions: View {
    
    @Query var locations: [Location]
    @Binding var searchResults: [MKMapItem]
    @Binding var searchResult: MKMapItem?
    @State var isSearchItemListPresented: Bool = false
    @Environment(\.isSearching) private var isSearching
    @State var resultClosure: (MKMapItem) -> ()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        List {
            Section {
                ForEach(locations) { location in
                    RecentLocationRow(location: location)
                }
            } header: {
                Text("Recent Locations")
            }
            
            Section {

            } header: {
                Text("Recent Searches")
            }
            
            Section {

            } header: {
                Text("Nearby")
            }
        }
        
        .navigationTitle("Location Search")
        .onChange(of: searchResults) {
            isSearchItemListPresented.toggle()
        }


        

        .sheet(isPresented: $isSearchItemListPresented) {
            searchResults = []
        } content: {
            LocationSearchResults(searchResults: $searchResults, resultClosure: resultClosure)
                .presentationDetents([.medium], selection: .constant(.medium))
                .presentationDragIndicator(.visible)
                .presentationBackgroundInteraction(.enabled(upThrough: .medium))
        }
//        .sheet(item: $searchResult) {
//            
//        } content: { mapItem in
//            HStack {
//                Text(mapItem.description)
//                Button("Use as step location") {
//                    var mapItems: [MKMapItem] = []
//                    mapItems.append(mapItem)
//                }
//            }
//            .presentationDetents([.medium])
//            .presentationDragIndicator(.visible)
//            .presentationBackgroundInteraction(.enabled(upThrough: .medium))
//        }
    }
}

//#Preview {
//    LocationSuggestions(searchResults: .constant([]), searchResult: .constant(nil))
//        .modelContainer(SampleContainer.sample())
//}
