//
//  AppDelegate.swift
//  Footprints
//
//  Created by Jill Allan on 31/01/2024.
//

import Foundation
import UIKit
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    
    @State var locationHandler: LocationHandler
    @State var mapSearchService: MapSearchService
    
    override init() {
        let locationHandler = LocationHandler()
        let mapSearchService = MapSearchService()
        _locationHandler = State(wrappedValue: locationHandler)
        _mapSearchService = State(wrappedValue: mapSearchService)
    }

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        let locationHandler = LocationHandler.shared
        locationHandler.startLocationUpdates()
        
        // If location updates were previously active, restart them after the background launch.
        if locationHandler.updatesStarted {
            locationHandler.startLocationUpdates()
        }
        // If a background activity session was previously active, reinstantiate it after the background launch.
        if locationHandler.backgroundActivity {
            locationHandler.backgroundActivity = true
        }
        return true
    }
}
