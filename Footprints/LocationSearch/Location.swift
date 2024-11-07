//
//  Location.swift
//  Footprints
//
//  Created by Jill Allan on 31/10/2024.
//

import Foundation
import MapKit
import SwiftData

@Model
final class Location {
    var name: String
    var subThoroughfare: String?
    var thoroughfare: String?
    var subLocality: String?
    var locality: String?
    var subAdministrativeArea: String?
    var administrativeArea: String?
    var postalCode: String?
    var isoCountryCode: String?
    var country: String?
    var inlandWater: String?
    var ocean: String?
    var areaOfInterest: String?
    var pointOfInterestCategory: String?
    var mapItemIdentifier: String?
    var latitude: Double?
    var longitude: Double?
    var radius: Double?
    var locationType: LocationType?
    var locationCategory: LocationCategory?
    var encodedMapItem: Data?
    
    var steps = [Step]()

    var locationSteps: [Step] {
        return steps.sorted()
    }
    
    /// Required property for CustomDebugStringConvertible protocol
    var debugDescription: String {
//        """
//        \(name), \
//        is: \(String(describing: pointOfInterestCategory)), \
//        location type: \(String(describing: locationType?.rawValue)), locationCatergoryType: \(String(describing: locationCategory)), icon: \(String(describing: locationCategory?.icon)))
//        """
        
        """
        Location(name: "\(name)",\n \
        subThoroughfare: "\(subThoroughfare ?? "nil")",\n \
        thoroughfare: "\(thoroughfare ?? "nil")",\n \
        subLocality: "\(subLocality ?? "nil")",\n \
        locality: "\(locality ?? "nil")",\n \
        subAdministrativeArea: "\(subAdministrativeArea ?? "nil")",\n \
        administrativeArea: "\(administrativeArea ?? "nil")",\n \
        postalCode: "\(postalCode ?? "nil")",\n \
        isoCountryCode: "\(isoCountryCode ?? "nil")",\n \
        country: "\(country ?? "nil")",\n \
        inlandWater: "\(inlandWater ?? "nil")",\n \
        ocean: "\(ocean ?? "nil")",\n \
        areaOfInterest: "\(areaOfInterest ?? "nil")",\n \
        pointOfInterestCategory: "\(pointOfInterestCategory ?? "nil")",\n \
        mapItemIdentifier: "\(mapItemIdentifier ?? "nil")",\n \
        latitude: \(latitude ?? 0.0),\n \
        longitude: \(longitude ?? 0.0),\n \
        radius: \(radius ?? 0.0),\n \
        locationType: .\(locationType ?? .other),\n \
        locationCategory: .\(locationCategory ?? .other)\n \
        )
        """
    }
    
    init(
        name: String,
        subThoroughfare: String? = nil,
        thoroughfare: String? = nil,
        subLocality: String? = nil,
        locality: String? = nil,
        subAdministrativeArea: String? = nil,
        administrativeArea: String? = nil,
        postalCode: String? = nil,
        isoCountryCode: String? = nil,
        country: String? = nil,
        inlandWater: String? = nil,
        ocean: String? = nil,
        areaOfInterest: String? = nil,
        pointOfInterestCategory: String? = nil,
        mapItemIdentifier: String? = nil,
        latitude: Double? = nil,
        longitude: Double? = nil,
        radius: Double? = nil,
        locationType: LocationType? = nil,
        locationCategory: LocationCategory? = nil,
        encodedMapItem: Data? = nil
    ) {
        self.name = name
        self.subThoroughfare = subThoroughfare
        self.thoroughfare = thoroughfare
        self.subLocality = subLocality
        self.locality = locality
        self.subAdministrativeArea = subAdministrativeArea
        self.administrativeArea = administrativeArea
        self.postalCode = postalCode
        self.isoCountryCode = isoCountryCode
        self.country = country
        self.inlandWater = inlandWater
        self.ocean = ocean
        self.areaOfInterest = areaOfInterest
        self.pointOfInterestCategory = pointOfInterestCategory
        self.mapItemIdentifier = mapItemIdentifier
        self.latitude = latitude
        self.longitude = longitude
        self.radius = radius
        self.locationType = locationType
        self.locationCategory = locationCategory
        self.encodedMapItem = encodedMapItem
    }
    
    convenience init(coordinate: CLLocationCoordinate2D, mapItem: MKMapItem, resultType: LocationType) {
        
        let region = mapItem.placemark.region
        let radius = region?.getRadius()
        var locationType: LocationType?
        var locationCategory: LocationCategory?
        
        if let pointOfInterestCategory = mapItem.pointOfInterestCategory {
            locationCategory = pointOfInterestCategory.convertCategoryToLocationCategory()
            locationType = LocationType.pointOfInterest
        }
        
        let data = mapItem.encode()
        
        self.init(
            name: mapItem.name ?? "name",
            subThoroughfare: mapItem.placemark.subThoroughfare,
            thoroughfare: mapItem.placemark.thoroughfare,
            subLocality: mapItem.placemark.subLocality,
            locality: mapItem.placemark.locality,
            subAdministrativeArea: mapItem.placemark.subAdministrativeArea,
            administrativeArea: mapItem.placemark.administrativeArea,
            postalCode: mapItem.placemark.postalCode,
            isoCountryCode: mapItem.placemark.isoCountryCode,
            country: mapItem.placemark.country,
            inlandWater: mapItem.placemark.inlandWater,
            ocean: mapItem.placemark.ocean,
            areaOfInterest: mapItem.placemark.areasOfInterest?.first,
            pointOfInterestCategory: mapItem.pointOfInterestCategory?.rawValue,
            mapItemIdentifier: mapItem.identifier?.rawValue,
            latitude: mapItem.placemark.location?.coordinate.latitude ?? coordinate.latitude,
            longitude: mapItem.placemark.location?.coordinate.longitude ?? coordinate.longitude,
            radius: radius,
            locationType: locationType,
            locationCategory: locationCategory,
            encodedMapItem: data
        )
    }
}
