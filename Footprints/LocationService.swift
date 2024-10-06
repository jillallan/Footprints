//
//  LocationService.swift
//  Footprints
//
//  Created by Jill Allan on 06/10/2024.
//

import CoreLocation
import Foundation

struct LocationService {
    let geocoder = CLGeocoder()
    
    func fetchPlacemark(for location: CLLocation) async throws -> CLPlacemark? {
        let placemarks = try await geocoder.reverseGeocodeLocation(location)
        if let placemark = placemarks.first {
            return placemark
        } else {
            return nil
        }
    }
}
