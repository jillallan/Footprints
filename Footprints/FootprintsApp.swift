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

//    @State var locationHandler = LocationHandler()
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appDelegate.locationHandler)
        }
        .modelContainer(appDelegate.container)
    }
}

