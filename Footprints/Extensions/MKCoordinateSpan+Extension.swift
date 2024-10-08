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

    static func calculateSpan(of coordinates: [CLLocationCoordinate2D], addMargin: Bool = false) -> Self? {
        var marginFactor = 1.0

        if addMargin {
            marginFactor = 1.15
        }

        let latitude = Double.range(of: coordinates.map(\.latitude))
        let longitude = Double.range(of: coordinates.map(\.longitude))

        if let latitude,
           let longitude {
            return MKCoordinateSpan(latitudeDelta: latitude * marginFactor, longitudeDelta: longitude * marginFactor)
        } else {
            return nil
        }
    }
}
