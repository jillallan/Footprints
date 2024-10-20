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
    
    func fetchPlacemark(for coordinate: CLLocationCoordinate2D) async throws -> CLPlacemark? {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let placemarks = try await geocoder.reverseGeocodeLocation(location)
        if let placemark = placemarks.first {
            return placemark
        } else {
            return nil
        }
    }
    
    func fetchLocation(for addressString: String) async throws -> CLLocation? {
        let locations = try await geocoder.geocodeAddressString(addressString)
        if let location = locations.first?.location {
            return location
        } else {
            return nil
        }
    }
    
    func fetchPlacemark(for addressString: String) async throws -> CLPlacemark? {
        let placemarks = try await geocoder.geocodeAddressString(addressString)
        if let placemark = placemarks.first {
            return placemark
        } else {
            return nil
        }
    }
}
