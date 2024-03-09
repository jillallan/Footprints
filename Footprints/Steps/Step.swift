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
final class Step: CustomDebugStringConvertible {
    
    // MARK: - Properties
    var timestamp: Date
    var latitude: Double
    var longitude: Double
    
    var trip: Trip?
    var location: Location?
    
    // MARK: - Computed Properties
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var region: MKCoordinateRegion {
        MKCoordinateRegion.calculateRegion(from: [coordinate], padding: 0.0)
    }
    
    var mapItem: MKMapItem {
        // FIXME: save and load with encoder, for when no interenet acccess
        MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        
    }
    
    var cameraPosition: MapCameraPosition {
        MapCameraPosition.item(mapItem)
    }
    
    var debugDescription: String {
        "Step: \(timestamp), Lat: \(latitude), Lon: \(longitude), Location: \(String(describing: location?.name))"
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
