//
//  MapSearchService.swift
//  Footprints
//
//  Created by Jill Allan on 05/01/2024.
//

import Foundation

import MapKit
import OSLog
import SwiftUI

@Observable class MapSearchService {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: MapSearchService.self)
    )
    
    var searchResults: [MKMapItem] = []
    
    @MainActor
    func search(for query: String, in region: MKCoordinateRegion) async {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.region = region
        searchRequest.naturalLanguageQuery = query
        
        
        let search = MKLocalSearch(request: searchRequest)
        
        do {
            let searchResponse = try await search.start()
            print(searchResponse.mapItems)
            self.searchResults = searchResponse.mapItems
            
        } catch {
            logger.error("Unable to perform search result: \(error.localizedDescription)")
        }
    }
    
    func clearSearchResults() {
        searchResults = []
    }
}

extension MapSearchService {
    static var preview: MapSearchService = {
        MapSearchService()
    }()
}
