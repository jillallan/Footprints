//
//  Placemark.swift
//  Footprints
//
//  Created by Jill Allan on 18/10/2024.
//

import Foundation
import MapKit
import SwiftData

@Model
final class Placemark {
    var title: String?
    var subtitle: String?
    var name: String?
    var thoroughfare: String?
    var subthoughfare: String?
    var locality: String?
    var sublocality: String?
    var administrativeArea: String?
    var subAdministrativeArea: String?
    var postalCode: String?
    var isoCountryCode: String?
    var country: String?
    var inlandWater: String?
    var ocean: String?
    var areaOfInterest: String?
//    var PointOfInterestCategory: MKPointOfInterestCategory?
//    var timeZone: TimeZone?
    
    var latitude: Double?
    var longitude: Double?
    var radius: Double?
    
    var steps = [Step]()

    var placemarkSteps: [Step] {
        return steps.sorted()
    }
    
    init(
        title: String? = nil,
        subtitle: String? = nil,
        name: String? = nil,
        thoroughfare: String? = nil,
        subthoughfare: String? = nil,
        locality: String? = nil,
        sublocality: String? = nil,
        administrativeArea: String? = nil,
        subAdministrativeArea: String? = nil,
        postalCode: String? = nil,
        isoCountryCode: String? = nil,
        country: String? = nil,
        inlandWater: String? = nil,
        ocean: String? = nil,
        areaOfInterest: String? = nil,
//        PointOfInterestCategory: MKPointOfInterestCategory? = nil,
//        timeZone: TimeZone? = nil,
        latitude: Double? = nil,
        longitude: Double? = nil,
        radius: Double? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.name = name
        self.thoroughfare = thoroughfare
        self.subthoughfare = subthoughfare
        self.locality = locality
        self.sublocality = sublocality
        self.administrativeArea = administrativeArea
        self.subAdministrativeArea = subAdministrativeArea
        self.postalCode = postalCode
        self.isoCountryCode = isoCountryCode
        self.country = country
        self.inlandWater = inlandWater
        self.ocean = ocean
        self.areaOfInterest = areaOfInterest
//        self.PointOfInterestCategory = PointOfInterestCategory
//        self.timeZone = timeZone
        self.latitude = latitude
        self.longitude = longitude
        self.radius = radius
    }
    
    convenience init(title: String, subtitle: String, placemark: CLPlacemark) {
        var radius = 0.0
        if let region = placemark.region {
            radius = CLRegion.getRadius(from: region) ?? 0.0
        }
        
        self.init(
            title: title,
            subtitle: subtitle,
            name: placemark.name,
            thoroughfare: placemark.thoroughfare,
            subthoughfare: placemark.subThoroughfare,
            locality: placemark.locality,
            sublocality: placemark.subLocality,
            administrativeArea: placemark.administrativeArea,
            subAdministrativeArea: placemark.subAdministrativeArea,
            postalCode: placemark.postalCode,
            isoCountryCode: placemark.isoCountryCode,
            country: placemark.country,
            inlandWater: placemark.inlandWater,
            ocean: placemark.ocean,
            areaOfInterest: placemark.areasOfInterest?.first,
//            timeZone: placemark.timeZone,
            latitude: placemark.location?.coordinate.latitude,
            longitude: placemark.location?.coordinate.longitude,
            radius: radius
        )
    }
}
