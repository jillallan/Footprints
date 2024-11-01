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
    
    let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: PreviewDataGenerator.self))

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
        
        for step in steps {
            modelContext.insert(step)
            Trip.bedminsterToBeijing.steps.append(step)
            do {
                if let mapItem = try await locationService.findNearestMapItem(at: step.coordinate) {
                    let location = Location(coordinate: step.coordinate, mapItem: mapItem.0, resultType: mapItem.1)
                    print("location: \(location.debugDescription)")
                    location.steps.append(step)
                }
            } catch {
                
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
