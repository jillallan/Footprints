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
@MainActor
class LocationHandler: NSObject {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: LocationHandler.self)
    )
    
//    static let shared = LocationHandler()  // Create a single, shared instance of the object.
    private let manager: CLLocationManager
    private var background: CLBackgroundActivitySession?
//    var getLastLocation: ((CLLocation?) -> Void)?
    
    var lastLocation = CLLocation()
    var isStationary = false
    var count = 0
    
    
    var locationUpdatesAvailable: Bool = UserDefaults.standard.bool(forKey: "locationUpdatesAvailable") {
        didSet {
            UserDefaults.standard.set(locationUpdatesAvailable, forKey: "locationUpdatesAvailable")
        }
    }
    
    var significantLocationChangeMonitoringAvailable: Bool = UserDefaults.standard.bool(forKey: "significantLocationChangeMonitoringAvailable") {
        didSet {
            UserDefaults.standard.set(significantLocationChangeMonitoringAvailable, forKey: "significantLocationChangeMonitoringAvailable")
        }
    }
    
    var updatesStarted: Bool = UserDefaults.standard.bool(forKey: "liveUpdatesStarted") {
        didSet {
            UserDefaults.standard.set(updatesStarted, forKey: "liveUpdatesStarted")
        }
    }
    
    var backgroundActivity: Bool = UserDefaults.standard.bool(forKey: "BGActivitySessionStarted") {
        didSet {
            backgroundActivity ? self.background = CLBackgroundActivitySession() : self.background?.invalidate()
            UserDefaults.standard.set(backgroundActivity, forKey: "BGActivitySessionStarted")
        }
    }
    
    
    override init() {
        // Creating a location manager instance is safe to call here in `MainActor`.
        self.manager = CLLocationManager()
        super.init()
        manager.delegate = self
    }
    
    func checklocationUpdatesAvailable() {
        locationUpdatesAvailable = CLLocationManager.locationServicesEnabled()
    }
    
    func checkSignificantLocationChangeMonitoringAvailable() {
        locationUpdatesAvailable = CLLocationManager.significantLocationChangeMonitoringAvailable()
    }
    
    func startLocationUpdates() {
        if self.manager.authorizationStatus == .notDetermined {
            self.manager.requestWhenInUseAuthorization()
        }
        self.logger.info("Starting location updates")
        
        Task {
            do {
                self.updatesStarted = true
                let updates = CLLocationUpdate.liveUpdates()
                for try await update in updates {
                    if !self.updatesStarted { break } // End location updates by breaking out of the loop.
                    if let location = update.location {
                        self.lastLocation = location
                        self.isStationary = update.isStationary
                        self.count += 1
//                        getLastLocation?(location)
                        print("Location \(self.count): \(self.lastLocation)")
                    }
                }
            } catch {
                print("Could not start location updates")
            }
        }
    }
    
    func stopLocationUpdates() {
        print("Stopping location updates")
        self.updatesStarted = false
        self.backgroundActivity = false
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
//
//    func enableLocationServices() {
//        // TODO: enable
//    }
//    
//    func disableLocationServices() {
//        // TODO: disable
//    }
//
//    
//    func getLocale() -> Locale {
//        return Locale.current
//    }
}

extension LocationHandler: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            lastLocation = location
        }
    }
}

extension LocationHandler {
    static var preview: LocationHandler = {
        LocationHandler()
    }()
}
