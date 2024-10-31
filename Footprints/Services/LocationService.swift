//
//  LocationService.swift
//  Footprints
//
//  Created by Jill Allan on 06/10/2024.
//

import CoreLocation
import Foundation
import MapKit
import OSLog

struct LocationService {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: LocationService.self))
    
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
    
    func fetchPointOfInterestMapItems(for coordinate: CLLocationCoordinate2D) async throws -> [MKMapItem] {
        let request = MKLocalPointsOfInterestRequest(center: coordinate, radius: 50)
        
        let search = MKLocalSearch(request: request)
        let response = try await search.start()
        return response.mapItems
    }
    
    func fetchMapItems(
        for query: String,
        in region: MKCoordinateRegion? = nil,
        resultType: MKLocalSearch.ResultType? = nil
    ) async throws -> [MKMapItem] {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        
        if let region {
            request.region = region
        }
        
        if let resultType {
            request.resultTypes = resultType
        }

        let search = MKLocalSearch(request: request)
        let response = try await search.start()
        return response.mapItems
    }
    
    func findNearestMapItem(at coordinate: CLLocationCoordinate2D) async throws -> MKMapItem? {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 50, longitudinalMeters: 50)
        var mapItems: [MKMapItem] = []
        
        do {
            let pointsOfInterest = try await fetchPointOfInterestMapItems(for: coordinate)
            logger.debug("Points of interest: \(pointsOfInterest.debugDescription)")
            mapItems.append(contentsOf: pointsOfInterest)
        } catch {
            logger.debug("points od interest error: \(error.localizedDescription)")
        }
        
        
        let query = try await fetchPlacemark(for: coordinate)
        
        if let queryString = query?.localAddressString {
            do {
                let physicalFeatures = try await fetchMapItems(for: queryString, in: region, resultType: .physicalFeature)
                logger.debug("Physical features: \(physicalFeatures.debugDescription)")
                mapItems.append(contentsOf: physicalFeatures)
            } catch {
                logger.debug("physical feature error: \(error.localizedDescription)")
            }
            
            do {
                let other = try await fetchMapItems(for: queryString, in: region)
                logger.debug("Other: \(other.debugDescription)")
                mapItems.append(contentsOf: other)
            } catch {
                logger.debug("other result type error: \(error.localizedDescription)")
            }
            
            do {
                let addresses = try await fetchMapItems(for: queryString, in: region, resultType: .address)
                logger.debug("Address: \(addresses.debugDescription)")
                mapItems.append(contentsOf: addresses)
            } catch {
                logger.debug("address result type error: \(error.localizedDescription)")
            }
        }
        
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        logger.debug("Location: \(location.debugDescription)")
        
        let nearestMapItem = mapItems.min { mapItem1, mapItem2 in
            let distance1 = mapItem1.placemark.location?.distance(from: location) ?? .greatestFiniteMagnitude
            let distance2 = mapItem2.placemark.location?.distance(from: location) ?? .greatestFiniteMagnitude
            
            return distance1 < distance2
    
        }
        logger.debug("map item: \(nearestMapItem.debugDescription)")
        
        return nearestMapItem
    }
    
}
