//
//  MockLocationManager.swift
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
    
    var handleRequestLocation: (() -> CLLocation)?
    
    func requestLocation() {
        guard let location = handleRequestLocation?() else { return }
        locatableDelegate?.locatable(self, didUpdateLocations: [location])
    }
    
    func requestAlwaysAuthorization() {}
    func startMonitoringVisits() {}
    func startMonitoringSignificantLocationChanges() {}
    func stopMonitoringSignificantLocationChanges() {}
    func stopMonitoringVisits() {}
}
