//
//  MockDataContainer.swift
//  FootprintsTests
//
//  Created by Jill Allan on 27/10/2023.
//

import Foundation
import SwiftData
@testable import Footprints

struct MockDataContainer {
    let container: ModelContainer
    
    init(inMemory: Bool) {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
            container = try ModelContainer(for: Trip.self, configurations: configuration)
            print(String(describing: container))
        } catch {
            fatalError("Unable to load model container: \(error.localizedDescription)")
        }
    }
}
