//
//  LocalSearchCompleter.swift
//  Footprints
//
//  Created by Jill Allan on 23/02/2024.
//

import Foundation
import MapKit
import OSLog
import SwiftUI

struct SearchCompletions: Identifiable {
    let id = UUID()
    let title: String
    let subTitle: String
}

@Observable class MapSearchService: NSObject {
    
    private let logger = Logger(category: String(describing: MapSearchService.self))
    
    let completer = MKLocalSearchCompleter()
    var completions = [SearchCompletions]()
    
    override init() {
        super.init()
        completer.delegate = self
    }
    
    func search(for query: String, in region: MKCoordinateRegion) {
        completer.region = region
        completer.queryFragment = query
    }
    
    func search(for query: String, in region: MKCoordinateRegion) async -> [MKMapItem] {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.region = region
        searchRequest.naturalLanguageQuery = query
        
        let search = MKLocalSearch(request: searchRequest)
        
        do {
            let searchResponse = try await search.start()
            logger.debug("\(#function) : \(#line) : Unable to perform search result: \(searchResponse.mapItems)")
            return searchResponse.mapItems
            
        } catch {
            logger.error("Unable to perform search result: \(error.localizedDescription)")
            return []
        }
    }
}

extension MapSearchService: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
      
        logger.debug("\(#function) : \(#line) : \(String(describing: completer.results.map(\.debugDescription)))")
        completions = completer.results.map {.init(title: $0.title, subTitle: $0.subtitle) }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {

    }
}

extension MapSearchService {
    static var preview: MapSearchService = {
        let localSearchCompleter = MapSearchService()
        
        localSearchCompleter.search(for: "coffee", in: MKCoordinateRegion.example)
        
        return localSearchCompleter
    }()
    
    static var completions: [SearchCompletions] {
        [
            SearchCompletions(title: "The Rising Sun", subTitle: "Pensford"),
            SearchCompletions(title: "George and Dragon", subTitle: "Pensford"),
            SearchCompletions(title: "Travellers Rest", subTitle: "Pensford"),
        ]
    }
}
