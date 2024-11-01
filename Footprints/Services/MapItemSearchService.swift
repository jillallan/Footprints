//
//  MapItemSearchService.swift
//  Footprints
//
//  Created by Jill Allan on 10/10/2024.
//

import RealModule
import Foundation
import MapKit

@Observable
final class MapItemSearchService: ObservableObject {
    var mapItems: [MKMapItem] = []
    
    func search(for query: String, in region: MKCoordinateRegion) async throws -> MKMapItem? {
        let request = MKLocalSearch.Request()
        request.region = region
        request.naturalLanguageQuery = query
        
        let search = MKLocalSearch(request: request)
        
        let response = try await search.start()
        guard let mapItem = response.mapItems.first else { return nil }
        
//        let region = CLCircularRegion(center: mapItem.placemark.coordinate, radius: 20.0, identifier: "testRegion")
        
//        mapItem.placemark.region?.radius
//        print(mapItem.placemark.region?.identifier)
    
        
        return mapItem
    }
}
