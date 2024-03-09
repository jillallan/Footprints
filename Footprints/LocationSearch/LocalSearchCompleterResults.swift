//
//  LocalSearchCompleterResults.swift
//  Footprints
//
//  Created by Jill Allan on 24/02/2024.
//

import MapKit
import SwiftUI

struct LocalSearchCompleterResults: View {
    let results: [SearchCompletions]
    let region: MKCoordinateRegion
    @Binding var searchResults: [MKMapItem]
    @State var searchResult: MKMapItem?
    @State private var isSelectedResultPresented: Bool = false
//    @Binding var resultClosure: ([MKMapItem]) -> ()
    
    var body: some View {
        ForEach(results) { result in
            Button {
                if result.subTitle != "Search Nearby" {
//                    Task {
//                        let result = await search(for: result.title + result.subTitle)
//                        result.flatMap { success in
//                            searchResult = success
//                        }
//                        
//                    }
                    
              
                } else {
                    search2(for: result.title)
                }

            } label: {
                VStack(alignment: .leading) {
                    Text(result.title)
                    Text(result.subTitle)
                }
            }
            .buttonStyle(.plain)
        }
        .sheet(item: $searchResult) {
            
        } content: { mapItem in
            HStack {
                Text(mapItem.description)
                Button("Use as step location") {
                    var mapItems: [MKMapItem] = []
                    mapItems.append(mapItem)
                }
            }
            .presentationDetents([.medium], selection: .constant(.medium))
            .presentationDragIndicator(.visible)
            .presentationBackgroundInteraction(.enabled(upThrough: .medium))
        }
        .sheet(isPresented: $isSelectedResultPresented) {
            
        } content: {
            List {
                ForEach(searchResults) { result in
                    Text(result.name ?? "No name")
                }
            }
            .presentationDetents([.medium], selection: .constant(.medium))
            .presentationDragIndicator(.visible)
            .presentationBackgroundInteraction(.enabled(upThrough: .medium))
        }
        .onChange(of: searchResults) {
            isSelectedResultPresented.toggle()
        }
    }
    
    func search(for place: String) async -> Result<MKMapItem, LocalSearchError> {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.region = region
        searchRequest.naturalLanguageQuery = place
        
        let search = MKLocalSearch(request: searchRequest)
        let searchResponse = try? await search.start()
        if let result = searchResponse?.mapItems.first {
            return Result.success(result)
        } else {
            return Result.failure(LocalSearchError.resultError)
        }
    }
    
    
    func search2(for query: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.region = region
        searchRequest.naturalLanguageQuery = query
        
        Task {
            let search = MKLocalSearch(request: searchRequest)
            let searchResponse = try? await search.start()
            searchResults = searchResponse?.mapItems ?? []

        }
    }
}

enum LocalSearchError: Error {
    case connectionError, resultError
}

//#Preview {
//    LocalSearchCompleterResults()
//}
