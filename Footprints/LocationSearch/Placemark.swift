////
////  Placemark.swift
////  Footprints
////
////  Created by Jill Allan on 18/10/2024.
////
//
//import Foundation
//import MapKit
//import SwiftData
//
//@Model
//final class Placemark {
//    var name: String?
//    var thoroughfare: String?
//    var subthoughfare: String?
//    var locality: String?
//    var sublocality: String?
//    var administrativeArea: String?
//    var subAdministrativeArea: String?
//    var postalCode: String?
//    var isoCountryCode: String?
//    var country: String?
//    var inlandWater: String?
//    var ocean: String?
//    var areaOfInterest: String?
//    var pointOfInterestCategory: String?
////    var PointOfInterestCategory: MKPointOfInterestCategory?
////    var timeZone: TimeZone?
//    
//    var latitude: Double?
//    var longitude: Double?
//    var radius: Double?
//    
//    var steps = [Step]()
//
//    var placemarkSteps: [Step] {
//        return steps.sorted()
//    }
//    
//    var subtitle: String? {
//        "TBC"
//    }
//    
//    var placemarkType: String {
//        if subthoughfare == nil && thoroughfare == nil && sublocality == nil && locality != nil {
//            return "city"
//        }
//        return "None"
//    }
//    
//    var firstLineOfAddress: String? {
//        if let subthoughfare, let thoroughfare {
//            return "\(subthoughfare) \(thoroughfare)"
//        }
//        if let thoroughfare {
//            return thoroughfare
//        }
//        if let subthoughfare {
//            return subthoughfare
//        }
//        return nil
//    }
//    
//    var localitySublocality: String? {
//        if let sublocality, let locality {
//            return "\(sublocality), \(locality)"
//        }
//        if let locality {
//            return locality
//        }
//        if let sublocality {
//            return sublocality
//        }
//        return nil
//    }
//    
//    var administrativeAreaSubAdministrativeArea: String? {
//        if let subAdministrativeArea, let administrativeArea {
//            return "\(subAdministrativeArea), \(administrativeArea)"
//        }
//        if let administrativeArea {
//            return administrativeArea
//        }
//        if let subAdministrativeArea {
//            return subAdministrativeArea
//        }
//        return nil
//    }
//    
//    var geography: String? {
//        if let inlandWater, let ocean {
//            return "\(inlandWater) \(ocean)"
//        }
//        if let inlandWater {
//            return inlandWater
//        }
//        if let ocean {
//            return ocean
//        }
//        return ""
//    }
//    
//    var address: String? {
//        if let firstLineOfAddress,
//            let localitySublocality,
//            let administrativeAreaSubAdministrativeArea,
//            let postalCode,
//            let country {
//            
//            return "\(firstLineOfAddress), \(localitySublocality), \(administrativeAreaSubAdministrativeArea), \(postalCode), \(country)"
//        } else if let localitySublocality,
//                  let administrativeAreaSubAdministrativeArea,
//                  let postalCode,
//                  let country {
//            return "\(localitySublocality), \(administrativeAreaSubAdministrativeArea), \(postalCode), \(country)"
//        } else if let administrativeAreaSubAdministrativeArea,
//                  let postalCode,
//                  let country {
//            return "\(administrativeAreaSubAdministrativeArea), \(postalCode), \(country)"
//        } else if let postalCode,
//                  let country {
//            return "\(postalCode), \(country)"
//        } else if let country {
//            return country
//        } else {
//            return ""
//        }
//    }
//    
//    init(
//        name: String? = nil,
//        thoroughfare: String? = nil,
//        subthoughfare: String? = nil,
//        locality: String? = nil,
//        sublocality: String? = nil,
//        administrativeArea: String? = nil,
//        subAdministrativeArea: String? = nil,
//        postalCode: String? = nil,
//        isoCountryCode: String? = nil,
//        country: String? = nil,
//        inlandWater: String? = nil,
//        ocean: String? = nil,
//        areaOfInterest: String? = nil,
//        pointOfInterestCategory: String? = nil,
////        PointOfInterestCategory: MKPointOfInterestCategory? = nil,
////        timeZone: TimeZone? = nil,
//        latitude: Double? = nil,
//        longitude: Double? = nil,
//        radius: Double? = nil
//    ) {
//        self.name = name
//        self.thoroughfare = thoroughfare
//        self.subthoughfare = subthoughfare
//        self.locality = locality
//        self.sublocality = sublocality
//        self.administrativeArea = administrativeArea
//        self.subAdministrativeArea = subAdministrativeArea
//        self.postalCode = postalCode
//        self.isoCountryCode = isoCountryCode
//        self.country = country
//        self.inlandWater = inlandWater
//        self.ocean = ocean
//        self.areaOfInterest = areaOfInterest
//        self.pointOfInterestCategory = pointOfInterestCategory
////        self.PointOfInterestCategory = PointOfInterestCategory
////        self.timeZone = timeZone
//        self.latitude = latitude
//        self.longitude = longitude
//        self.radius = radius
//    }
//    
//    convenience init(placemark: CLPlacemark) {
//        var radius = 0.0
//        if let region = placemark.region {
//            radius = CLRegion.getRadius(from: region) ?? 0.0
//        }
//        
//        self.init(
//            name: placemark.name,
//            thoroughfare: placemark.thoroughfare,
//            subthoughfare: placemark.subThoroughfare,
//            locality: placemark.locality,
//            sublocality: placemark.subLocality,
//            administrativeArea: placemark.administrativeArea,
//            subAdministrativeArea: placemark.subAdministrativeArea,
//            postalCode: placemark.postalCode,
//            isoCountryCode: placemark.isoCountryCode,
//            country: placemark.country,
//            inlandWater: placemark.inlandWater,
//            ocean: placemark.ocean,
//            areaOfInterest: placemark.areasOfInterest?.first,
////            timeZone: placemark.timeZone,
//            latitude: placemark.location?.coordinate.latitude,
//            longitude: placemark.location?.coordinate.longitude,
//            radius: radius
//        )
//    }
//    
//    convenience init(placemark: CLPlacemark, mapItem: MKMapItem) {
//        var radius = 0.0
//        if let region = placemark.region {
//            radius = CLRegion.getRadius(from: region) ?? 0.0
//        }
//        
//        self.init(
//            name: placemark.name,
//            thoroughfare: placemark.thoroughfare,
//            subthoughfare: placemark.subThoroughfare,
//            locality: placemark.locality,
//            sublocality: placemark.subLocality,
//            administrativeArea: placemark.administrativeArea,
//            subAdministrativeArea: placemark.subAdministrativeArea,
//            postalCode: placemark.postalCode,
//            isoCountryCode: placemark.isoCountryCode,
//            country: placemark.country,
//            inlandWater: placemark.inlandWater,
//            ocean: placemark.ocean,
//            areaOfInterest: placemark.areasOfInterest?.first,
//            pointOfInterestCategory: mapItem.pointOfInterestCategory?.rawValue,
////            timeZone: placemark.timeZone,
//            latitude: placemark.location?.coordinate.latitude,
//            longitude: placemark.location?.coordinate.longitude,
//            radius: radius
//        )
//    }
//}
