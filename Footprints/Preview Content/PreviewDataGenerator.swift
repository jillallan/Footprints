//
//  PreviewDataGenerator.swift
//  Footprints
//
//  Created by Jill Allan on 09/08/2024.
//

import Foundation
import SwiftData
import SwiftUI

/// A helper function to generate the sample data
///
/// The data is defined on an extension for each model
struct PreviewDataGenerator {

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

        modelContext.insert(Step.bedminsterStation)
        modelContext.insert(Step.templeMeads)
        modelContext.insert(Step.paddington)
        modelContext.insert(Step.stPancras)
        modelContext.insert(Step.Ixelles)

        Trip.bedminsterToBeijing.steps.append(Step.bedminsterStation)
        Trip.bedminsterToBeijing.steps.append(Step.templeMeads)
        Trip.bedminsterToBeijing.steps.append(Step.paddington)
        Trip.bedminsterToBeijing.steps.append(Step.stPancras)
        Trip.bedminsterToBeijing.steps.append(Step.Ixelles)

    }

    /// A random image to display in trip view
    static var randomTripImage: ImageResource {
        let images: [ImageResource] = [.EBC_1, .EBC_2, .EBC_3]
        let randomInt = Int.random(in: 0...2)
        return images[randomInt]
    }
}
