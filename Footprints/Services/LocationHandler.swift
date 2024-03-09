//
//  LocationManager.swift
//  Footprints
//
//  Created by Jill Allan on 31/01/2024.
//

import CoreLocation
import Foundation
import OSLog
import SwiftData

@Observable
class LocationHandler: NSObject {
    
    enum AuthorisationStatus: Int {
        case notDetermined, denied, authorised

    }
    
    private let logger = Logger(category: String(describing: LocationHandler.self))
    
    let context: ModelContext
    private let locationManager = CLLocationManager()
    var lastLocation = CLLocation()
    var count = 0
    var authorizationStatus: AuthorisationStatus = .notDetermined
    //    var locationManagerCallback: ((CLLocation) -> ())?
    
    
    
    var updatesStarted: Bool = UserDefaults.standard.bool(forKey: "liveUpdatesStarted") {
        didSet {
            UserDefaults.standard.set(updatesStarted, forKey: "liveUpdatesStarted")
        }
    }
    
    var locationUpdatesAuthorized: Int = UserDefaults.standard.integer(forKey: "locationUpdatesAuthorized") {
        didSet {
            UserDefaults.standard.set(locationUpdatesAuthorized, forKey: "locationUpdatesAuthorized")
        }
    }
    
    
    init(context: ModelContext) {
        self.context = context
        super.init()
        logger.debug("\(#function) : \(#line) : location handler initiated, status :\(self.locationUpdatesAuthorized)")
        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//        locationManager.distanceFilter = 200
#if os(iOS)
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = true
#endif
        
    }
    
    
    
    func requestLocation() {
        logger.debug("\(#function) : \(#line) : location requested")
        locationManager.requestLocation()
    }
    
    func requestLocation(completion: @escaping (CLLocation) -> ()) {
        // https://stackoverflow.com/questions/41542393/core-location-delegates-value-in-closures
        locationManager.requestLocation()
//        locationManagerCallback = completion
    }

    func startLocationServices() {
        guard CLLocationManager.significantLocationChangeMonitoringAvailable() else {
            return // Add alert
        }
        
        updatesStarted = true
        
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
    
    func enableLocationServices() {
        guard CLLocationManager.significantLocationChangeMonitoringAvailable() else {
            return // Add alert
        }
        
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            updatesStarted = true
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .denied, .restricted:
            return
        default:
            return
        }
    }
    
    func disableLocationServices() {
   
    }
    
    func stopLocationUpdates() {

    }

//    private var continuation: CheckedContinuation<CLLocation, Error>?
//    var currentLocation: CLLocation {
//        get async throws {
//            return try await withCheckedThrowingContinuation { continuation in
//                self.continuation = continuation
//                locationManager.requestLocation()
//            }
//        }
//    }
    
//    func requestLocation() async throws -> CLLocation {
//        // https://www.createwithswift.com/updating-the-users-location-with-core-location-and-swift-concurrency-in-swiftui/
//        return try await currentLocation
//    }
    
//    func getLocale() -> Locale {
//        return Locale.current
//    }
}

extension LocationHandler: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        logger.debug("\(#function) : \(#line) : locationManagerDidChangeAuthorization: \(manager.authorizationStatus)")
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:  // Location services are available.
            locationUpdatesAuthorized = AuthorisationStatus.authorised.rawValue
            break
            
        case .denied, .restricted:  // Location services currently unavailable.
            locationUpdatesAuthorized = AuthorisationStatus.denied.rawValue
            disableLocationServices()
            break
            
        case .notDetermined:        // Authorization not determined yet.
            locationUpdatesAuthorized = AuthorisationStatus.notDetermined.rawValue
            break
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        continuation?.resume(throwing: error)
//        continuation = nil
    }
    
    @MainActor
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            lastLocation = location
            
//            locationManagerCallback?(location)
//            continuation?.resume(returning: location)
            
            logger.debug("\(#function) : \(#line) : \(String(describing: location))")
            
            let dataHandler = DataHandler()
            if let trip = dataHandler.fetchActiveTrip(context: context) {
                logger.debug("\(#function) : \(#line) : \(trip.debugDescription)")
                
                let step = Step(
                    timestamp: location.timestamp,
                    latitude: location.coordinate.latitude,
                    longitude: location.coordinate.longitude
                )
                
                step.trip = trip
                context.insert(step)
                logger.debug("\(#function) : \(#line) : trip step: \(String(describing: trip.steps?.first.debugDescription))")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {

    }
}

@MainActor
extension LocationHandler {
    static var preview: LocationHandler = {
        LocationHandler(context: SampleContainer.sample().mainContext)
    }()
}
