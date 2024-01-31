//
//  FootprintsApp.swift
//  Footprints
//
//  Created by Jill Allan on 27/10/2023.
//

import SwiftData
import SwiftUI

@main
struct FootprintsApp: App {

    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appDelegate.mapSearchService)
                .environment(appDelegate.locationHandler)
        }
        .modelContainer(for: Trip.self, inMemory: true, isUndoEnabled: true)
    }
}
