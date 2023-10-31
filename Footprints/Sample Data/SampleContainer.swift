//
//  SampleContainer.swift
//  Footprints
//
//  Created by Jill Allan on 30/10/2023.
//

import Foundation
import SwiftData

struct SampleContainer {
    static var sample: () -> ModelContainer = {
        do {
            let schema = Schema([Trip.self])
            let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: schema, configurations: [configuration])
            Task { @MainActor in
                await SampleDataGenerator.generateSampleData(modelContext: container.mainContext)
//                container.mainContext.insert(Trip.bedminsterToBeijing)
//                container.mainContext.insert(Trip.mountains)
            }
            return container
        } catch {
            fatalError("Error loading SampleContainer")
        }
    }
}
