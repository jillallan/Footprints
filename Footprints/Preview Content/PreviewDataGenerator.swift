//
//  PreviewDataGenerator.swift
//  Footprints
//
//  Created by Jill Allan on 09/08/2024.
//

import Foundation
import MapKit
import OSLog
import SwiftData
import SwiftUI

/// A helper function to generate the sample data
///
/// The data is defined on an extension for each model
struct PreviewDataGenerator {
    
    static let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: PreviewDataGenerator.self))

    /// A helper function to generate the sample data
    /// - Parameter modelContext: The model context to use to generate the data
    @MainActor static func generatePreviewData(modelContext: ModelContext) async {
        modelContext.insert(Trip.bedminsterToBeijing)
        modelContext.insert(Trip.mountains)
        modelContext.insert(Trip.anglesey)
        modelContext.insert(Trip.france)
        modelContext.insert(Trip.greece)
        modelContext.insert(Trip.london)
        modelContext.insert(Trip.spain)
        
        let steps = [
            Step.stJohnsLane,
            Step.bedminsterStation,
            Step.templeMeads,
            Step.paddington,
            Step.stPancras,
            Step.brusselsMidi,
            Step.grandPlace,
            Step.atomium,
            Step.cologne,
            Step.warsaw,
            Step.everestBaseCamp,
            Step.statueOfLiberty
        ]
        
        let locationService = LocationService()
        
        steps.forEach { step in
            modelContext.insert(step)
            Trip.bedminsterToBeijing.steps.append(step)
        }
        
        
        Task { @MainActor in
            try await steps.concurrentForEach { step in
                if let mapItem = try await locationService.fetchPointOfInterestMapItems(for: step.coordinate).first {
                    logger.debug("map item data preview: \(mapItem.debugDescription)")
                    let location = Location(mapItem: mapItem)
                    modelContext.insert(location)
                    step.location = location
                }
            }
        }
    }

    /// A random image to display in trip view
    static var randomTripImage: ImageResource {
        let images: [ImageResource] = [.EBC_1, .EBC_2, .EBC_3]
        let randomInt = Int.random(in: 0...2)
        return images[randomInt]
    }
}
