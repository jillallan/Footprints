//
//  MKCoordinateRegion+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 19/01/2024.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    static func calculateRegion(from coordinates: [CLLocationCoordinate2D], padding: Double) -> MKCoordinateRegion {
        
        let center = CLLocationCoordinate2D.centre(of: coordinates)
        let span = MKCoordinateSpan.span(of: coordinates, padding: padding)
        
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
}
