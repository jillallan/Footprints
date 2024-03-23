//
//  LocationManager.swift
//  Footprints
//
//  Created by Jill Allan on 31/01/2024.
//

//import Combine
import CoreLocation
import Foundation
import OSLog
import SwiftData

enum MyLocationError: Error {
    case noLocationError
}

// MARK: - Protocol for testing
protocol Locatable {
    var locatableDelegate: LocatableDelegate? { get set }
    var allowsBackgroundLocationUpdates: Bool { get set }
    var showsBackgroundLocationIndicator: Bool { get set }
    var authorizationStatus: CLAuthorizationStatus { get }
    func requestLocation()
    func requestAlwaysAuthorization()
    func startMonitoringVisits()
    func startMonitoringSignificantLocationChanges()
    func stopMonitoringSignificantLocationChanges()
    func stopMonitoringVisits()
}

protocol LocatableDelegate {
//    func locationPublisher() -> AnyPublisher<[CLLocation], Never>
    func locatableDidChangeAuthorization(_ manager: CLLocationManager)
    func locatable(_ manager: Locatable, didUpdateLocations locations: [CLLocation])
    func locatable(_ manager: Locatable, didFailWithError error: Error)
    func locatable(_ manager: Locatable, didVisit visit: CLVisit)
}

// MARK: - Conform to protocol
extension CLLocationManager: Locatable {
    var locatableDelegate: LocatableDelegate? {
        get { return delegate as! LocatableDelegate? }
        set { delegate = newValue as! CLLocationManagerDelegate? }
    }
}

@Observable
class LocationHandler: NSObject {
    private let logger = Logger(category: String(describing: LocationHandler.self))
    
    enum AuthorisationStatus: Int {
        case notDetermined, denied, authorised
    }

    var locationManager: Locatable
    let context: ModelContext
    var locationContinuation: CheckedContinuation<CLLocation, Error>?
    private var authorizationStatus: AuthorisationStatus = .notDetermined
    
    var lastLocation: CLLocation {
        get async throws {
            return try await withCheckedThrowingContinuation { continuation in
                self.locationContinuation = continuation
                locationManager.requestLocation()
            }
        }
    }
    
    // MARK: - User defaults
    var locationUpdatesAuthorized: Int = UserDefaults.standard.integer(forKey: "locationUpdatesAuthorized") {
        didSet {
            UserDefaults.standard.set(locationUpdatesAuthorized, forKey: "locationUpdatesAuthorized")
        }
    }
    
    // MARK: - Initialization
    init(context: ModelContext, locationManager: Locatable = CLLocationManager()) {
        self.context = context
        self.locationManager = locationManager
        super.init()
        logger.debug("location handler initiated, status :\(self.locationUpdatesAuthorized)")
        self.locationManager.locatableDelegate = self
#if os(iOS)
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.showsBackgroundLocationIndicator = true
#endif

    }
    
    // MARK: - Methods
    func enableLocationServices() {
        guard CLLocationManager.significantLocationChangeMonitoringAvailable() else {
            return // Add alert
        }
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationUpdatesAuthorized = AuthorisationStatus.authorised.rawValue
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .denied, .restricted:
            return
        default:
            return
        }
    }
    
    func startLocationServices() {
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
    
    func stopLocationServices() {
        locationManager.stopMonitoringSignificantLocationChanges()
        locationManager.stopMonitoringVisits()
    }
    
    // MARK: - Async method

    func currentLocation() async throws -> CLLocation {
        locationManager.requestLocation()
        return try await withCheckedThrowingContinuation { continuation in
            locationContinuation = continuation
            locationManager.requestLocation()
        }
    }
    
    func getCurrentLocation() {
        locationManager.requestLocation()
    }
    
//    func getLocale() -> Locale {
//        return Locale.current
//    }
}

extension LocationHandler: LocatableDelegate {
    func locatableDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:  // Location services are available.
            locationUpdatesAuthorized = AuthorisationStatus.authorised.rawValue
            break
            
        case .denied, .restricted:  // Location services currently unavailable.
            locationUpdatesAuthorized = AuthorisationStatus.denied.rawValue
            stopLocationServices()
            break
            
        case .notDetermined:        // Authorization not determined yet.
            locationUpdatesAuthorized = AuthorisationStatus.notDetermined.rawValue
            break
            
        default:
            break
        }
    }
    
    func locatable(_ manager: Locatable, didFailWithError error: Error) {
        logger.error("Location manager did fail with error: \(error.localizedDescription)")
        locationContinuation?.resume(throwing: error)
        locationContinuation = nil
    }
    
    @MainActor
    func locatable(_ manager: Locatable, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.first else { return }
        logger.debug("\(String(describing: location))")
 
        if let location = locations.first {
            locationContinuation?.resume(returning: location)
        } else {
            locationContinuation?.resume(throwing: MyLocationError.noLocationError)
        }

        
        let dataHandler = DataHandler()
        if let trip = dataHandler.fetchActiveTrip(context: context) {
            
            let step = Step(
                timestamp: location.timestamp,
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
            
            step.trip = trip
            context.insert(step)
        }
    }
    
    func locatable(_ manager: Locatable, didVisit visit: CLVisit) {
        
    }
}

// MARK: - Call protocol methods in delegate methods
extension LocationHandler: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.locatableDidChangeAuthorization(manager)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locatable(manager, didFailWithError: error)
    }
    
    @MainActor
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locatable(manager, didUpdateLocations: locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        self.locatable(manager, didVisit: visit)
    }
}

@MainActor
extension LocationHandler {
    static var preview: LocationHandler = {
        LocationHandler(context: SampleContainer.sample().mainContext)
    }()
}
