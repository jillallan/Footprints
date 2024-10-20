//
//  MKCoordinateRegion+Extension.swift
//  Footprints
//
//  Created by Jill Allan on 27/09/2024.
//

import Foundation
import MapKit

extension MKCoordinateRegion: @retroactive Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        return lhs.span == rhs.span && lhs.center == rhs.center
    }
}

extension MKCoordinateRegion {
    static func defaultRegion() -> Self {
        MKCoordinateRegion(
            center: .init(latitude: 51.5, longitude: 0.0),
            span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    }
    
    static func calculateRegion(from coordinates: [CLLocationCoordinate2D], with Margin: Double = 1.0) -> Self {
        let centre = CLLocationCoordinate2D.calculateCentre(of: coordinates)
        let span = MKCoordinateSpan.calculateSpan(of: coordinates, marginFactor: Margin)

        return MKCoordinateRegion(center: centre, span: span)
    }
}
