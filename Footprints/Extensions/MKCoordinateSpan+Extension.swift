//
//  MKCoordinateSpan+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 19/01/2024.
//

import Foundation
import MapKit

extension MKCoordinateSpan: Equatable {
    public static func == (lhs: MKCoordinateSpan, rhs: MKCoordinateSpan) -> Bool {
        return lhs.latitudeDelta == rhs.latitudeDelta && lhs.longitudeDelta == rhs.longitudeDelta
    }
}

extension MKCoordinateSpan {
    static func span(of coordinates: [CLLocationCoordinate2D], padding: Double = 0.0) -> MKCoordinateSpan? {

        let latitude = Double.range(of: coordinates.map(\.latitude))
        let longitude = Double.range(of: coordinates.map(\.longitude))
        
        if let latitude,
           let longitude {
            
            return MKCoordinateSpan(latitudeDelta: latitude + padding, longitudeDelta: longitude + padding)
            // If the latitude or longitude is 0 create a small lat or long
//            return MKCoordinateSpan(
//                latitudeDelta: latitude == 0.0 ? 0.002 : latitude * 1.5,
//                longitudeDelta: longitude == 0.0 ? 0.002 : longitude * 1.5
//            )
        } else {
            return nil
        }
    }
    
    static var example: MKCoordinateSpan {
        MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    }
}
