import CoreLocation
import MapKit
import Foundation
import SwiftUI
import UIKit


var greeting = "Hello, playground"

let locationService = LocationService()
Task {
    let mapItem = try await locationService.findNearestMapItem(at: CLLocationCoordinate2D(
        latitude: 51.449532,
        longitude: -2.589309
    ))
    
    var locationCategory: LocationCategory?

    if let pointOfInterestCategory = mapItem?.pointOfInterestCategory {
        pointOfInterestCategory

        let locationCategoryn = convertToLocationCategory(from: pointOfInterestCategory)
        locationCategoryn
    }
    
    func convertToLocationCategory(from pointOfInterestCategory: MKPointOfInterestCategory) -> LocationCategory {
        let pointOfInterestString = pointOfInterestCategory.rawValue.lowercased()
        let category = LocationCategory.allCases.first { locationCategory in
            pointOfInterestString.contains(locationCategory.rawValue)
        }
        return category ?? .other
    }
}


