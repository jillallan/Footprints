//
//  Location.swift
//  Footprints
//
//  Created by Jill Allan on 19/01/2024.
//

import CoreLocation
import Foundation
import SwiftData

@Model
final class Location: PlacemarkDescribable {
    
    // MARK: - Properties
    var latitude: Double
    var longitude: Double
    var name: String?
    var subThoroughfare: String?
    var thoroughfare: String?
    var subAdministrativeArea: String?
    var administrativeArea: String?
    var subLocality: String?
    var locality: String?
    var postalCode: String?
    var country: String?
    var isoCountryCode: String?
    var inlandWater: String?
    var ocean: String?
    var areaOfInterest: String?
    var createdDate: Date
    
    // MARK: - Relationships
    var steps: [Step]? = []
    
    // MARK: - Computed Properties
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var title: String {
        if let name {
            return name
        }
        return "No name"
    }

    var jointThoroughfare: String? {
        if let subThoroughfare,
           let thoroughfare {
            return subThoroughfare + " " + thoroughfare
        } else if let thoroughfare {
            return thoroughfare
        }
        return nil
    }
    
    var subTitle: String {
//        if let jointThoroughfare {
//            return jointThoroughfare
//        }
        if let jointAdministrativeArea {
            return jointAdministrativeArea
        }
        return "No name"
    }
    
    var jointAdministrativeArea: String? {
        if let subAdministrativeArea,
           let administrativeArea {
            return subAdministrativeArea + " " + administrativeArea
        } else if let administrativeArea {
            return administrativeArea
        }
        return nil
    }

    // MARK: - Initialization
    init(latitude: Double, longitude: Double, name: String? = nil, subThoroughfare: String? = nil, thoroughfare: String? = nil, subAdministrativeArea: String? = nil, administrativeArea: String? = nil, subLocality: String? = nil, locality: String? = nil, postalCode: String? = nil, country: String? = nil, isoCountryCode: String? = nil, inlandWater: String? = nil, ocean: String? = nil, areaOfInterest: String? = nil, createdDate: Date) {
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.subThoroughfare = subThoroughfare
        self.thoroughfare = thoroughfare
        self.subAdministrativeArea = subAdministrativeArea
        self.administrativeArea = administrativeArea
        self.subLocality = subLocality
        self.locality = locality
        self.postalCode = postalCode
        self.country = country
        self.isoCountryCode = isoCountryCode
        self.inlandWater = inlandWater
        self.ocean = ocean
        self.areaOfInterest = areaOfInterest
        self.createdDate = createdDate
    }
    
    convenience init(cLPlacemark: CLPlacemark) {
        self.init(
            latitude: cLPlacemark.location?.coordinate.latitude ?? 0.0,
            longitude: cLPlacemark.location?.coordinate.longitude ?? 0.0,
            name: cLPlacemark.name,
            subThoroughfare: cLPlacemark.subThoroughfare,
            thoroughfare: cLPlacemark.thoroughfare,
            subAdministrativeArea: cLPlacemark.subAdministrativeArea,
            administrativeArea: cLPlacemark.administrativeArea,
            subLocality: cLPlacemark.subLocality,
            locality: cLPlacemark.locality,
            postalCode: cLPlacemark.postalCode,
            country: cLPlacemark.country,
            isoCountryCode: cLPlacemark.isoCountryCode,
            inlandWater: cLPlacemark.inlandWater,
            ocean: cLPlacemark.ocean,
            areaOfInterest: cLPlacemark.areaOfInterest,
            createdDate: Date.now
        )
    }
}

