//
//  CLLocationCoordinate2D.swift
//  Footprints
//
//  Created by Jill Allan on 27/09/2024.
//

import CoreLocation
import Foundation

extension CLLocationCoordinate2D: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let coordinate = try container.decode(CLLocationCoordinate2D.self)
        self = coordinate
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
    }
}

extension CLLocationCoordinate2D: @retroactive Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension CLLocationCoordinate2D: @retroactive Comparable {
    public static func < (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude < rhs.latitude && lhs.longitude < rhs.longitude
    }
}
