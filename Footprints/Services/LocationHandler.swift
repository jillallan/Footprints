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
class LocationHandler {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: LocationHandler.self)
    )
    
//    static let shared = LocationHandler()  // Create a single, shared instance of the object.
    private let manager: CLLocationManager
    private var background: CLBackgroundActivitySession?
    
    var lastLocation = CLLocation()
    var isStationary = false
    var count = 0
    
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
    
    init() {
        // Creating a location manager instance is safe to call here in `MainActor`.
        self.manager = CLLocationManager()
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
    
//
//    func enableLocationServices() {
//        // TODO: enable
//    }
//    
//    func disableLocationServices() {
//        // TODO: disable
//    }
//    
//    func requestLocation() {
//        
//    }
//    
//    func getLocale() -> Locale {
//        return Locale.current
//    }
}

extension LocationHandler {
    static var preview: LocationHandler = {
        LocationHandler()
    }()
}
