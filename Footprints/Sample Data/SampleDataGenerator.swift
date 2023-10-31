//
//  SampleDataGenerator.swift
//  Footprints
//
//  Created by Jill Allan on 30/10/2023.
//

import Foundation
import SwiftData


struct SampleDataGenerator {
    @MainActor static func generateSampleData(modelContext: ModelContext) async {
        modelContext.insert(Trip.bedminsterToBeijing)
        modelContext.insert(Trip.mountains)
    }
}
