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
import SwiftUI

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
    
    func fetchPlacemark(for coordinate: Coordinate) async throws -> MKPlacemark? {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let placemarks = try await geocoder.reverseGeocodeLocation(location)
        if let placemark = placemarks.first {
            return MKPlacemark(placemark: placemark)
        } else {
            return nil
        }
    }
    
    func fetchLocation(for addressString: String) async throws -> CLLocation? {
        let placemarks = try await geocoder.geocodeAddressString(addressString)
        if let location = placemarks.first?.location {
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
        let mapItems = response.mapItems
        return mapItems
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
    
    func fetchMapItems(
        for coordinate: CLLocationCoordinate2D,
        resultType: MKLocalSearch.ResultType? = nil
    ) async throws -> [MKMapItem] {
        
        guard let placemark = try await fetchPlacemark(for: coordinate) else { return [] }
        guard let queryString = placemark.localAddressString else { return [] }
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 50, longitudinalMeters: 50)
        
        return try await fetchMapItems(for: queryString, in: region, resultType: resultType)
    }
    
    func fetchPlacemarkMapItem(for coordinate: CLLocationCoordinate2D) async throws -> MKMapItem? {
        
        guard let placemark = try await fetchPlacemark(for: coordinate) else { return nil }
        let placemarkMapItem = MKMapItem(placemark: MKPlacemark(placemark: placemark))
        
        return placemarkMapItem
    }
    
    func fetchPlacemarkMapItem(for coordinate: Coordinate) async throws -> MKMapItem? {
        
        let clLocationCoordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        guard let placemark = try await fetchPlacemark(for: clLocationCoordinate) else { return nil }
        let placemarkMapItem = MKMapItem(placemark: MKPlacemark(placemark: placemark))
        
        return placemarkMapItem
    }
    
    func fetchMapItems(for coordinate: CLLocationCoordinate2D) async throws -> [MKMapItem] {
        var mapItems: [MKMapItem] = []

        guard let placemark = try await fetchPlacemark(for: coordinate) else { return mapItems }
        let placemarkMapItem = MKMapItem(placemark: MKPlacemark(placemark: placemark))
        mapItems.append(placemarkMapItem)
        
        let pointOfInterestMapItems = try await fetchPointOfInterestMapItems(for: coordinate)
        mapItems.append(contentsOf: pointOfInterestMapItems)
        
        return mapItems
    }
    
    func createMapItem(for coordinate: CLLocationCoordinate2D) async throws -> MKMapItem? {
        guard let placemark = try await fetchPlacemark(for: coordinate) else { return nil }
        let mapItem = MKMapItem(placemark: MKPlacemark(placemark: placemark))
        
        return mapItem
    }
    
    func fetchMapItem(for identifier: String) async throws -> MKMapItem? {
        guard let id = MKMapItem.Identifier(rawValue: identifier) else { return nil }
        let request = MKMapItemRequest(mapItemIdentifier: id)
        
        return try await request.mapItem
    }
    
    @MainActor
    func fetchMapItem(for mapFeature: MapFeature) async throws -> MKMapItem? {
        let request = MKMapItemRequest(feature: mapFeature)
        let mapItem = try await request.mapItem

        return mapItem
    }
    
    func chooseBestMapItem(for coordinate: CLLocationCoordinate2D) async throws -> MKMapItem? {
        logger.debug("coordinate: \(String(describing: coordinate))")
        guard let mapItem = try await fetchPointOfInterestMapItems(for: coordinate).first else { return nil }
        if mapItem.contains(coordinate: coordinate) {
            let distance = mapItem.placemark.location?.distance(from: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
            logger.debug("distance: \(String(describing: distance))")
            logger.debug("point of interest map item: \(mapItem.debugDescription)")
            return mapItem
        }
        guard let mapItem = try await fetchMapItems(for: coordinate).first else { return nil }
        if mapItem.contains(coordinate: coordinate) {
            logger.debug("fetched map item: \(mapItem.debugDescription)")
            return mapItem
        }
        let mapItem2 = try await createMapItem(for: coordinate)
        logger.debug("created map item: \(mapItem2.debugDescription)")
        return mapItem2
        
    }
    
}
    
//    func fetchAllMapItems(at coordinate: CLLocationCoordinate2D) async -> [MKMapItem] {
//        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 50, longitudinalMeters: 50)
//        var mapItems: [MKMapItem] = []
//        
//        logger.debug("Map items: \(mapItems.debugDescription) for coordinate: \(String(describing: coordinate))")
//        
//        let pointsOfInterest = await fetchPointOfInterestMapItems(for: coordinate)
//        mapItems.append(contentsOf: pointsOfInterest)
//        let physicalFeatures = await fetchMapItems(for: coordinate, in: region, resultType: .physicalFeature)
//        mapItems.append(contentsOf: physicalFeatures)
//        let addresses = await fetchMapItems(for: coordinate, in: region, resultType: .address)
//        mapItems.append(contentsOf: addresses)
//        let otherFeatures = await fetchMapItems(for: coordinate, in: region)
//        mapItems.append(contentsOf: otherFeatures)
//        
//        logger.debug("Map items: \(mapItems.count) for coordinate: \(String(describing: coordinate))")
//        
//        return mapItems
//    }
    
//    func findClosestMapItem(at coordinate: CLLocationCoordinate2D) async -> MKMapItem? {
//        logger.debug("hello!!!!")
//        
//        let mapItems = await fetchAllMapItems(at: coordinate)
//        logger.debug("Map items: \(mapItems.count) for coordinate: \(String(describing: coordinate))")
//        
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        
//        let nearestMapItem = mapItems.min { mapItem1, mapItem2 in
//            let distance1 = mapItem1.placemark.location?.distance(from: location) ?? .greatestFiniteMagnitude
//            let distance2 = mapItem2.placemark.location?.distance(from: location) ?? .greatestFiniteMagnitude
//            
//            return distance1 < distance2
//    
//        }
//        
//        return nearestMapItem
//    }
    
//    func findNearestMapItem(at coordinate: CLLocationCoordinate2D) async throws -> MKMapItem?  {
//        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 50, longitudinalMeters: 50)
//        var mapItems: [MKMapItem] = []
//        
//        do {
//            logger.debug("Point of interest query: \(String(describing: coordinate))")
//            let pointsOfInterest = try await fetchPointOfInterestMapItems(for: coordinate)
//            logger.debug("Point of interest: \(pointsOfInterest.debugDescription)")
//            mapItems.append(contentsOf: pointsOfInterest)
//        } catch {
//            logger.debug("points od interest error: \(error.localizedDescription)")
//        }
//        
//        let query = try await fetchPlacemark(for: coordinate)
//        
//        if let queryString = query?.localAddressString {
//            do {
//                logger.debug("Physical feature query: \(queryString)")
//                let physicalFeatures = try await fetchMapItems(for: queryString, in: region, resultType: .physicalFeature)
////                logger.debug("Physical features: \(physicalFeatures.debugDescription)")
//                mapItems.append(contentsOf: physicalFeatures)
//            } catch {
//                logger.debug("physical feature error: \(error.localizedDescription)")
//            }
//            
//            do {
//                logger.debug("Other query: \(queryString)")
//                let others = try await fetchMapItems(for: queryString, in: region)
////                logger.debug("Other: \(other.debugDescription)")
//                mapItems.append(contentsOf: others)
//            } catch {
//                logger.debug("other result type error: \(error.localizedDescription)")
//            }
//            
//            do {
//                logger.debug("Address query: \(queryString)")
//                let addresses = try await fetchMapItems(for: queryString, in: region, resultType: .address)
////                logger.debug("Address: \(addresses.debugDescription)")
//                mapItems.append(contentsOf: addresses)
//            } catch {
//                logger.debug("address result type error: \(error.localizedDescription)")
//            }
//        }
//        
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        logger.debug("Location: \(location.debugDescription)")
//        
//        let nearestMapItem = mapItems.min { mapItem1, mapItem2 in
//            let distance1 = mapItem1.placemark.location?.distance(from: location) ?? .greatestFiniteMagnitude
//            let distance2 = mapItem2.placemark.location?.distance(from: location) ?? .greatestFiniteMagnitude
//            
//            return distance1 < distance2
//    
//        }
//        logger.debug("map item: \(nearestMapItem.debugDescription)")
//        logger.debug("map item point of interest: \(nearestMapItem?.pointOfInterestCategory?.rawValue ?? "No place of interest")")
//        
//        return nearestMapItem
//    }
    
//}
