//
//  CLPlacemark+extension.swift
//  Footprints
//
//  Created by Jill Allan on 25/10/2024.
//

import CoreLocation
import Foundation

enum PlaceType: String {
    case road
    case other
    case lake
    case river
    case stream
    case pond
    case inlandWater
}

extension CLPlacemark {
    var firstLineOfAddress: String? {
        if let subThoroughfare,
            let thoroughfare {
            return "\(subThoroughfare) \(thoroughfare)"
        }
        if let thoroughfare {
            return thoroughfare
        }
        if let subThoroughfare {
            return subThoroughfare
        }
        return nil
    }
    
    var localitySublocality: String? {
        if let subLocality, let locality {
            return "\(subLocality), \(locality)"
        }
        if let locality {
            return locality
        }
        if let subLocality {
            return subLocality
        }
        return nil
    }
    
    var administrativeAreaSubAdministrativeArea: String? {
        if subAdministrativeArea == locality {
            if let administrativeArea {
                return administrativeArea
            }
            return nil
        } else {
            if let subAdministrativeArea, let administrativeArea {
                return "\(subAdministrativeArea), \(administrativeArea)"
            }
            if let administrativeArea {
                return administrativeArea
            }
            if let subAdministrativeArea {
                return subAdministrativeArea
            }
            return nil
        }
        
    }
    
    static var sampleVar: String {
        "Hello"
    }
    
    public var addressString: String? {
        if let firstLineOfAddress,
            let localitySublocality,
            let administrativeAreaSubAdministrativeArea,
            let postalCode,
            let country {
            
            return "\(firstLineOfAddress), \(localitySublocality), \(administrativeAreaSubAdministrativeArea), \(postalCode), \(country)"
        } else if let localitySublocality,
                  let administrativeAreaSubAdministrativeArea,
                  let postalCode,
                  let country {
            return "\(localitySublocality), \(administrativeAreaSubAdministrativeArea), \(postalCode), \(country)"
        } else if let administrativeAreaSubAdministrativeArea,
                  let postalCode,
                  let country {
            return "\(administrativeAreaSubAdministrativeArea), \(postalCode), \(country)"
        } else if let postalCode,
                  let country {
            return "\(postalCode), \(country)"
        } else if let country {
            return country
        } else {
            return ""
        }
    }
    
    public var localAddressString: String? {
        if let firstLineOfAddress,
            let localitySublocality,
            let postalCode {
            return "\(firstLineOfAddress), \(localitySublocality), \(postalCode)"
        } else if let localitySublocality,
                  let postalCode {
            return "\(localitySublocality), \(postalCode)"
        } else if let postalCode {
            return postalCode
        } else {
            return ""
        }
    }
    
    var placemarkType: PlaceType {
        if subThoroughfare == nil && thoroughfare != nil {
            return .road
        }
        if let inlandWater {
            if inlandWater.lowercased().contains("lake") {
                return .lake
            } else if inlandWater.lowercased().contains("river") {
                return .river
            } else if inlandWater.lowercased().contains("stream") {
                return .stream
            } else if inlandWater.lowercased().contains("pond") {
                return .pond
            }
            else {
                return .inlandWater
            }
        }
//        if subThoroughfare == nil && thoroughfare == nil && subLocality == nil && locality != nil {
//            return "city"
//        }
        return .other
    }
}
