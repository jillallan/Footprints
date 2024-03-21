//
//  CurrentLocationProvider.swift
//  Footprints
//
//  Created by Jill Allan on 11/03/2024.
//

import CoreLocation
import Foundation

class CurrentLocationProvider: NSObject {
    let locationManager = CLLocationManager()
    var currentLocationCheckCallback: ((CLLocation) -> Void)?
    
    override init() {
        super.init()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.delegate = self
    }
    
    func checkCurrentLocation(completion: @escaping (Double) -> Void) {
        self.currentLocationCheckCallback = { [unowned self] location in
            completion(self.getLatitude(location))
        }
        
    }
    
    func getLatitude(_ location: CLLocation) -> Double {
        return location.coordinate.latitude
    }
}

extension CurrentLocationProvider: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.currentLocationCheckCallback?(location)
        self.currentLocationCheckCallback = nil
    }
}
