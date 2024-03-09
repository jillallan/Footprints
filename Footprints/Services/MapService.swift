//
//  LocationService.swift
//  Footprints
//
//  Created by Jill Allan on 26/01/2024.
//

import CoreLocation
import Foundation
import OSLog

enum NetworkError: Error {
    case geocodeError, placemarkError, locationError
}

struct MapService {
    private let logger = Logger(category: String(describing: MapService.self))
    
    let geocoder = CLGeocoder()

   
    func fetchLocation(for address: String) async -> Result<CLLocation, NetworkError> {

        do {
            let placemarks = try await geocoder.geocodeAddressString(address)
            if let location = placemarks.first?.location {
                return .success(location)
            } else {
                return .failure(.locationError)
            }
        } catch {
            return .failure(.geocodeError)
        }
    }
    
    func fetchPlacemark(for step: Step) async -> Result<CLPlacemark, NetworkError> {
        let location = CLLocation(latitude: step.latitude, longitude: step.longitude)
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                return .success(placemark)
            } else {
                logger.error("\(NetworkError.placemarkError.localizedDescription)")
                return .failure(.placemarkError)
            }
        } catch {
            logger.error("\(NetworkError.geocodeError.localizedDescription)")
            return .failure(.geocodeError)
        }
    }
    
    
    func fetchPlacemark(for coordinate: CLLocationCoordinate2D) async throws -> CLPlacemark {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let placemarks = try await geocoder.reverseGeocodeLocation(location)
        if let placemark = placemarks.first {
            return placemark
        } else {
            throw NetworkError.placemarkError
        }
    }
    
}
