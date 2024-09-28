//
//  Step.swift
//  Footprints
//
//  Created by Jill Allan on 09/08/2024.
//

import CoreLocation
import MapKit
import SwiftData
import SwiftUI

@Model
final class Step {
    var timestamp: Date
    var latitude: Double
    var longitude: Double
    var altitude: Double
    var trip: Trip?

    /// Required property for CustomDebugStringConvertible protocol
    var debugDescription: String {
        """
        Step on: \(timestamp.formatted(date: .abbreviated, time: .shortened)), \
        latitude: \(latitude), longitude: \(longitude), altitude: \(altitude))
        """
    }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var region: MKCoordinateRegion {
        MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan.sample)
    }

    /// Initializes a new instance of a Step
    /// - Parameters:
    ///   - timestamp: The time of the step, the defualt is the current time
    ///   - latitude: The latitude of the step
    ///   - longitude: The longitude of a step
    ///   - altitude: The altitude of a step
    init(timestamp: Date = .now, latitude: Double, longitude: Double, altitude: Double) {
        self.timestamp = timestamp
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
    }

    /// Initializes a new instance of a Step, with a default altitude of 0.0
    /// - Parameters:
    ///   - timestamp: The time of the step, the defualt is the current time
    ///   - latitude: The latitude of the step
    ///   - longitude: The longitude of a step
    convenience init(timestamp: Date = .now, latitude: Double, longitude: Double) {
        self.init(timestamp: timestamp, latitude: latitude, longitude: longitude, altitude: 0.0)
    }

    /// Initializes a new instance of a Step, with a default latitude, longtiude and altitude of 0.0
    ///   - timestamp: The time of the step, the defualt is the current time
    convenience init(timestamp: Date = .now) {
        self.init(timestamp: timestamp, latitude: 0.0, longitude: 0.0, altitude: 0.0)
    }
}

extension Step: Identifiable {}
