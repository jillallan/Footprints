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
    
    @State var mapSearchService = MapSearchService()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(mapSearchService)
        }
        .modelContainer(for: Trip.self, inMemory: true, isUndoEnabled: true)
    }
}
