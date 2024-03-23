//
//  MockLocationHandler.swift
//  FootprintsTests
//
//  Created by Jill Allan on 11/03/2024.
//

import CoreLocation
import Foundation
@testable import Footprints

struct MockLocationManager: Locatable {
    var locatableDelegate: LocatableDelegate?
    var allowsBackgroundLocationUpdates: Bool
    var showsBackgroundLocationIndicator: Bool
    var authorizationStatus: CLAuthorizationStatus
    
    var handleRequestLocationCompletion: (() -> CLLocation)?
//    var handleRequestLocationContinuation: CheckedContinuation<CLLocation?, Error>?
    
    func requestLocation() {
        print("mock location manager request location")
        guard let location = handleRequestLocationCompletion?() else { return }
//        handleRequestLocationCompletion
        print("mock location manager request location: \(location.debugDescription)")
        locatableDelegate?.locatable(self, didUpdateLocations: [location])
        
//        guard let location = handleRequestLocationContinuation?.resume(returning: CLLocation(latitude: 51.5, longitude: 0.0)) else { return }
    }
    
    func requestAlwaysAuthorization() {}
    func startMonitoringVisits() {}
    func startMonitoringSignificantLocationChanges() {}
    func stopMonitoringSignificantLocationChanges() {}
    func stopMonitoringVisits() {}
}
