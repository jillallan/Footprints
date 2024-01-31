//
//  LocationService.swift
//  Footprints
//
//  Created by Jill Allan on 26/01/2024.
//

import CoreLocation
import Foundation
import OSLog

@Observable class MapService: NSObject {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: MapService.self)
    )
    
    var currentLocation: CLLocation?
    
    enum NetworkError: Error {
        case geocodeError, placemarkError, locationError
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
//        locationManager.allowsBackgroundLocationUpdates = true
//        locationManager.showsBackgroundLocationIndicator = true
    }
    
    let geocoder = CLGeocoder()
    let locationManager = CLLocationManager()
    
    func enableLocationServices() {
        // TODO: enable
        locationManager.startUpdatingLocation()
    }
    
    func disableLocationServices() {
        // TODO: disable
    }
    
//    func check() -> Bool {
//        if CLLocationManager.
//    }
   
    func fetchLocation(for address: String) async -> Result<CLLocation, NetworkError> {

        do {
            let placemarks = try await geocoder.geocodeAddressString(address)
            if let location = placemarks.first?.location {
                return .success(location)
            } else {
                return .failure(.locationError)
            }
        } catch {
            return .failure(.geocodeError)
        }
    }
    
    func fetchPlacemark(for step: Step) async -> Result<CLPlacemark, NetworkError> {
        let location = CLLocation(latitude: step.latitude, longitude: step.longitude)
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                return .success(placemark)
            } else {
                return .failure(.placemarkError)
            }
        } catch {
            return .failure(.geocodeError)
        }
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    func getLocale() -> Locale {
        return Locale.current
    }
}

extension MapService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorized, .authorizedAlways:
            enableLocationServices()
            break
        case .denied, .restricted:
            disableLocationServices()
            break
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first
    }
}
