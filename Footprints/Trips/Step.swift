//
//  Step.swift
//  Footprints
//
//  Created by Jill Allan on 02/11/2023.
//

import CoreLocation
import MapKit
import SwiftData
import SwiftUI

@Model
final class Step {
    // MARK: - Properties
    var timestamp: Date
    var latitude: Double
    var longitude: Double
    
    var trip: Trip?
    
    // MARK: - Computed Properties
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var region: MKCoordinateRegion {
        MKCoordinateRegion.calculateRegion(from: [coordinate], padding: 0.0)
    }
    
    // MARK: - Initialization
    init(timestamp: Date, latitude: Double, longitude: Double) {
        self.timestamp = timestamp
        self.latitude = latitude
        self.longitude = longitude
    }
}

// Added comparable comformance to enable sorting by timestamp
extension Step: Comparable {
    public static func < (lhs: Step, rhs: Step) -> Bool {
        lhs.timestamp < rhs.timestamp
    }
}
