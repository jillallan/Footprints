//
//  MapItemSearchService.swift
//  Footprints
//
//  Created by Jill Allan on 10/10/2024.
//

import Foundation
import MapKit

@Observable
final class MapItemSearchService: ObservableObject {
    var mapItems: [MKMapItem] = []
    
    func search(for query: String, in region: MKCoordinateRegion) async -> [MKMapItem] {
        let request = MKLocalSearch.Request()
        request.region = region
        request.naturalLanguageQuery = query
        
        let search = MKLocalSearch(request: request)
        
        do {
            let response = try await search.start()
//            self.mapItems = response.mapItems
            return response.mapItems
        } catch {
            print("Error fetching map item: \(error.localizedDescription)")
            return []
        }
    }
}
