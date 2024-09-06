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

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Trip.self)
    }
}
