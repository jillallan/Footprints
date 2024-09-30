//
//  Trip.swift
//  Footprints
//
//  Created by Jill Allan on 09/08/2024.
//

import MapKit
import SwiftData
import SwiftUI

@Model
/// A swift data model for a trip
final class Trip: CustomDebugStringConvertible {

    // MARK: - Properties

    /// The trip title
    var title: String

    /// The start date of the trip
    var startDate: Date

    /// The end date of the trip
    var endDate: Date

    /// Has the user enabled auto tracking using location services for this trip
    var isAutoTrackingOn: Bool

    var steps = [Step]()

    var tripSteps: [Step] {
        return steps.sorted()
    }


    // MARK: - Computed Properties

    var tripRegion: MKCoordinateRegion {

        if steps.isEmpty {
            return MKCoordinateRegion.defaultRegion()
        }

        if steps.count == 1 {
            if let coordinate = steps.first?.coordinate {
                return MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan.defaultSpan())
            } else {
                return MKCoordinateRegion.defaultRegion()
            }
        }

        if let span = MKCoordinateSpan.calculateSpan(of: steps.map(\.coordinate), addMargin: true),
           let centre = CLLocationCoordinate2D.calculateCentre(of: steps.map(\.coordinate)) {
            return MKCoordinateRegion(center: centre, span: span)
        }

        return MKCoordinateRegion.defaultRegion()
    }

    /// Required property for CustomDebugStringConvertible protocol
    var debugDescription: String {
        "Trip: \(title), start date: \(startDate), end date: \(endDate), tracking: \(isAutoTrackingOn))"
        // , step count: \(String(describing: steps?.count))"
    }

    // MARK: - Initialization

    /// Initializes a new instance of a trip
    /// - Parameters:
    ///   - title: The trip title
    ///   - startDate: The start date of the trip
    ///   - endDate: The end date of the trip
    ///   - isAutoTrackingOn: Has the user enabled auto tracking using location services for this trip
    init(title: String = "New Trip", startDate: Date = .now, endDate: Date = .now, isAutoTrackingOn: Bool = false) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.isAutoTrackingOn = isAutoTrackingOn
    }

    convenience init(trip: Trip) {
        self.init(
            title: trip.title,
            startDate: trip.startDate,
            endDate: trip.endDate,
            isAutoTrackingOn: trip.isAutoTrackingOn
        )
    }
}
