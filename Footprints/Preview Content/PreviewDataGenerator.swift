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
        modelContext.insert(Step.brusselsMidi)
        modelContext.insert(Step.grandPlace)
        modelContext.insert(Step.atomium)
        modelContext.insert(Step.cologne)
        modelContext.insert(Step.warsaw)
        
        let locationService = LocationService()
        do {
            if let clPlacemark = try await locationService.fetchPlacemark(for: Step.bedminsterStation.coordinate) {
                let placemark = Placemark(title: clPlacemark.name ?? "", subtitle: clPlacemark.name ?? "", placemark: clPlacemark)
                placemark.steps.append(Step.bedminsterStation)
            }
            
            if let clPlacemark = try await locationService.fetchPlacemark(for: Step.templeMeads.coordinate) {
                let placemark = Placemark(title: clPlacemark.name ?? "", subtitle: clPlacemark.name ?? "", placemark: clPlacemark)
                placemark.steps.append(Step.templeMeads)
            }
            
            if let clPlacemark = try await locationService.fetchPlacemark(for: Step.paddington.coordinate) {
                let placemark = Placemark(title: clPlacemark.name ?? "", subtitle: clPlacemark.name ?? "", placemark: clPlacemark)
                placemark.steps.append(Step.paddington)
            }
            
            if let clPlacemark = try await locationService.fetchPlacemark(for: Step.stPancras.coordinate) {
                let placemark = Placemark(title: clPlacemark.name ?? "", subtitle: clPlacemark.name ?? "", placemark: clPlacemark)
                placemark.steps.append(Step.stPancras)
            }
            
            if let clPlacemark = try await locationService.fetchPlacemark(for: Step.brusselsMidi.coordinate) {
                let placemark = Placemark(title: clPlacemark.name ?? "", subtitle: clPlacemark.name ?? "", placemark: clPlacemark)
                placemark.steps.append(Step.brusselsMidi)
            }
            
            if let clPlacemark = try await locationService.fetchPlacemark(for: Step.grandPlace.coordinate) {
                let placemark = Placemark(title: clPlacemark.name ?? "", subtitle: clPlacemark.name ?? "", placemark: clPlacemark)
                placemark.steps.append(Step.grandPlace)
            }
            
            if let clPlacemark = try await locationService.fetchPlacemark(for: Step.atomium.coordinate) {
                let placemark = Placemark(title: clPlacemark.name ?? "", subtitle: clPlacemark.name ?? "", placemark: clPlacemark)
                placemark.steps.append(Step.atomium)
            }
            
            if let clPlacemark = try await locationService.fetchPlacemark(for: Step.cologne.coordinate) {
                let placemark = Placemark(title: clPlacemark.name ?? "", subtitle: clPlacemark.name ?? "", placemark: clPlacemark)
                placemark.steps.append(Step.cologne)
            }
            
            if let clPlacemark = try await locationService.fetchPlacemark(for: Step.warsaw.coordinate) {
                let placemark = Placemark(title: clPlacemark.name ?? "", subtitle: clPlacemark.name ?? "", placemark: clPlacemark)
                placemark.steps.append(Step.warsaw)
            }
            
        } catch {
            
        }
        


        Trip.bedminsterToBeijing.steps.append(Step.bedminsterStation)
        Trip.bedminsterToBeijing.steps.append(Step.templeMeads)
        Trip.bedminsterToBeijing.steps.append(Step.paddington)
        Trip.bedminsterToBeijing.steps.append(Step.stPancras)
        Trip.bedminsterToBeijing.steps.append(Step.brusselsMidi)
        Trip.bedminsterToBeijing.steps.append(Step.grandPlace)
        Trip.bedminsterToBeijing.steps.append(Step.atomium)
        Trip.bedminsterToBeijing.steps.append(Step.cologne)
        Trip.bedminsterToBeijing.steps.append(Step.warsaw)

    }

    /// A random image to display in trip view
    static var randomTripImage: ImageResource {
        let images: [ImageResource] = [.EBC_1, .EBC_2, .EBC_3]
        let randomInt = Int.random(in: 0...2)
        return images[randomInt]
    }
}
