//
//  LocationManager.swift
//  Footprints
//
//  Created by Jill Allan on 31/01/2024.
//

import CoreLocation
import Foundation
import OSLog

@Observable
class LocationHandler: NSObject {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: LocationHandler.self)
    )
    
    private let locationManager = CLLocationManager()
//    var locationManagerCallback: ((CLLocation) -> ())?
    private var continuation: CheckedContinuation<CLLocation, Error>?
    
    var currentLocation: CLLocation {
        get async throws {
            return try await withCheckedThrowingContinuation { continuation in
                self.continuation = continuation
                locationManager.requestLocation()
            }
        }
    }
    
    var lastLocation = CLLocation()
    var count = 0
    
    
    var updatesStarted: Bool = UserDefaults.standard.bool(forKey: "liveUpdatesStarted") {
        didSet {
            UserDefaults.standard.set(updatesStarted, forKey: "liveUpdatesStarted")
        }
    }
    
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
#if os(iOS)
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = true
#endif
        
    }
    
    func requestLocation() {
        print("location requested")
        locationManager.requestLocation()
    }
    
    func requestLocation() async throws -> CLLocation {
        // https://www.createwithswift.com/updating-the-users-location-with-core-location-and-swift-concurrency-in-swiftui/
        return try await currentLocation
    }
    
    func requestLocation(completion: @escaping (CLLocation) -> ()) {
        // https://stackoverflow.com/questions/41542393/core-location-delegates-value-in-closures
        locationManager.requestLocation()
//        locationManagerCallback = completion
    }

    func enablePowerSavingLocationServices() {
        guard CLLocationManager.significantLocationChangeMonitoringAvailable() else {
            return // Add alert
        }
        
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startMonitoringVisits()
            locationManager.startMonitoringSignificantLocationChanges()
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .denied, .restricted:
            return
        default:
            return
        }
    }
    
    func enableHighPowerLocationServices() {
        guard CLLocationManager.locationServicesEnabled() else {
            return // Add alert
        }
        
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .denied, .restricted:
            return
        default:
            return
        }
    }
    
    func disableLocationServices() {
        // TODO: disable
    }
    
    func stopLocationUpdates() {
        print("Stopping location updates")
        self.updatesStarted = false
    }

    
//    func getLocale() -> Locale {
//        return Locale.current
//    }
}

extension LocationHandler: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            lastLocation = location
//            locationManagerCallback?(location)
            continuation?.resume(returning: location)
            print(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        // TODO:
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        continuation?.resume(throwing: error)
        continuation = nil
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:  // Location services are available.
            enablePowerSavingLocationServices()
            break
            
        case .restricted, .denied:  // Location services currently unavailable.
            disableLocationServices()
            break
            
        case .notDetermined:        // Authorization not determined yet.
           manager.requestWhenInUseAuthorization()
            break
            
        default:
            break
        }
    }
}

extension LocationHandler {
    static var preview: LocationHandler = {
        LocationHandler()
    }()
}
