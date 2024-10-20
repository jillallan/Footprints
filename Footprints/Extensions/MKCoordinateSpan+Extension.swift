//
//  MKCoordinateSpan+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 09/08/2024.
//

import Foundation
import MapKit

extension MKCoordinateSpan {
    public static func == (lhs: MKCoordinateSpan, rhs: MKCoordinateSpan) -> Bool {
        return lhs.latitudeDelta == rhs.latitudeDelta && lhs.longitudeDelta == rhs.longitudeDelta
    }

    static let sample = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)

    static func defaultSpan() -> Self {
        MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    }

    static func calculateSpan(of coordinates: [CLLocationCoordinate2D], marginFactor: Double = 1.0) -> Self {

        var latitude = Double.range(of: coordinates.map(\.latitude)) ?? 0.01
        var longitude = Double.range(of: coordinates.map(\.longitude)) ?? 0.01
        
        if latitude == 0.0 {
            latitude = 0.01
        }
        
        if longitude == 0.0 {
            longitude = 0.01
        }
        
        return MKCoordinateSpan(latitudeDelta: latitude * marginFactor, longitudeDelta: longitude * marginFactor)
    }
}
