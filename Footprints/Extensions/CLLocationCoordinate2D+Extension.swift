//
//  CLLocationCoordinate2D+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 19/01/2024.
//

import CoreLocation
import Foundation
import OSLog


// Added equatable conformance so we can fetch steps based on their coordinates
extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension CLLocationCoordinate2D {
    static let logger = Logger(category: String(describing: CLLocationCoordinate2D.self))
    
    static func random() -> CLLocationCoordinate2D {
        let latitude = Double.random(in: -90...90)
        let longitude = Double.random(in: -180...180)
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func centre(of coordinates: [CLLocationCoordinate2D]) -> CLLocationCoordinate2D? {
        logger.debug("\(coordinates)")
        
        let latitude = Double.midRange(of: coordinates.map(\.latitude))
        let longitude = Double.midRange(of: coordinates.map(\.longitude))
        
        logger.debug("lat: \(String(describing: latitude)) & lon: \(String(describing: longitude))")
        
        if let latitude,
           let longitude {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            return nil
        }
    }
    
    static var example: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: 51.5, longitude: 0.0)
    }
}
