//
//  LocationService.swift
//  Footprints
//
//  Created by Jill Allan on 26/01/2024.
//

import CoreLocation
import Foundation
import OSLog

@Observable class LocationService {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: LocationService.self)
    )
    
    enum NetworkError: Error {
        case geocodeError, placemarkError
    }
    
    let geocoder = CLGeocoder()
    
    func fetchPlacemark(for step: Step) async -> Result<CLPlacemark, NetworkError> {
        let location = CLLocation(latitude: step.latitude, longitude: step.longitude)
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                return .success(placemark)
            } else {
                return .failure(.placemarkError)
            }
        } catch {
            return .failure(.geocodeError)
        }
    }
}
