//
//  MKCoordinateRegion+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 19/01/2024.
//

import Foundation
import MapKit
import OSLog

extension MKCoordinateRegion {
    static let logger = Logger(category: String(describing: MKCoordinateRegion.self))
    
    static func calculateRegion(from coordinates: [CLLocationCoordinate2D], padding: Double) -> MKCoordinateRegion {

        logger.debug("\(coordinates)")
        
        let center = CLLocationCoordinate2D.centre(of: coordinates)
        let span = MKCoordinateSpan.span(of: coordinates, padding: padding)
    
        logger.debug("\(center.debugDescription)")
        logger.debug("\(span.debugDescription)")
        
        if let center,
           let span {
            return MKCoordinateRegion(center: center, span: span)
        } else {
            return MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
                span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
            )
        }
    }
    
    static var example: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D.example, span: MKCoordinateSpan.example)
    }
}
