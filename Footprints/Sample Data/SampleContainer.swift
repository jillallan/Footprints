//
//  SampleContainer.swift
//  Footprints
//
//  Created by Jill Allan on 30/10/2023.
//

import Foundation
import SwiftData

struct SampleContainer {
    let container: ModelContainer
    
    init(inMemory: Bool) {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
            container = try ModelContainer(for: Trip.self, configurations: configuration)
        } catch {
            fatalError("Unable to load model container: \(error.localizedDescription)")
        }
        
        print("Container initialized")
    }
}
