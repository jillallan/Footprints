//
//  FootprintsApp.swift
//  Footprints
//
//  Created by Jill Allan on 09/08/2024.
//

import SwiftUI
import SwiftData

@main
struct FootprintsApp: App {
    @StateObject var navigationController = NavigationController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigationController)
        }
        .modelContainer(for: Trip.self)
    }
}
