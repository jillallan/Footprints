//
//  PreviewDataGenerator.swift
//  Footprints
//
//  Created by Jill Allan on 09/08/2024.
//

import Foundation
import MapKit
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

        modelContext.insert(Step.stJohnsLane)
        modelContext.insert(Step.bedminsterStation)
        modelContext.insert(Step.templeMeads)
        modelContext.insert(Step.paddington)
        modelContext.insert(Step.stPancras)
        modelContext.insert(Step.brusselsMidi)
        modelContext.insert(Step.grandPlace)
        modelContext.insert(Step.atomium)
        modelContext.insert(Step.cologne)
        modelContext.insert(Step.warsaw)
        modelContext.insert(Step.everestBaseCamp)
        modelContext.insert(Step.statueOfLiberty)
        
        let locationService = LocationService()
        let mapItemSearchService = MapItemSearchService()
        
        do {
            if let clPlacemark = try await locationService.findNearestMapItem(at: Step.stJohnsLane.coordinate)?.placemark {
                let placemark = Placemark(placemark: clPlacemark)
                placemark.steps.append(Step.stJohnsLane)
            }
            
            if let clPlacemark = try await locationService.findNearestMapItem(at: Step.bedminsterStation.coordinate)?.placemark {
                let placemark = Placemark(placemark: clPlacemark)
                placemark.steps.append(Step.bedminsterStation)
            }
            
            if let clPlacemark = try await locationService.findNearestMapItem(at: Step.templeMeads.coordinate)?.placemark {
                let placemark = Placemark(placemark: clPlacemark)
                placemark.steps.append(Step.templeMeads)
            }
            
            if let clPlacemark = try await locationService.findNearestMapItem(at: Step.paddington.coordinate)?.placemark {
                let placemark = Placemark(placemark: clPlacemark)
                placemark.steps.append(Step.paddington)
            }
            
            if let clPlacemark = try await locationService.findNearestMapItem(at: Step.stPancras.coordinate)?.placemark {
                let placemark = Placemark(placemark: clPlacemark)
                placemark.steps.append(Step.stPancras)
            }
            
            if let clPlacemark = try await locationService.findNearestMapItem(at: Step.brusselsMidi.coordinate)?.placemark {
                let placemark = Placemark(placemark: clPlacemark)
                placemark.steps.append(Step.brusselsMidi)
            }
            
            if let clPlacemark = try await locationService.findNearestMapItem(at: Step.grandPlace.coordinate)?.placemark {
                let placemark = Placemark(placemark: clPlacemark)
                placemark.steps.append(Step.grandPlace)
            }
            
            if let clPlacemark = try await locationService.findNearestMapItem(at: Step.atomium.coordinate)?.placemark {
                let placemark = Placemark(placemark: clPlacemark)
                placemark.steps.append(Step.atomium)
            }
            
            if let clPlacemark = try await locationService.findNearestMapItem(at: Step.cologne.coordinate)?.placemark {
                let placemark = Placemark(placemark: clPlacemark)
                placemark.steps.append(Step.cologne)
            }
            
            if let clPlacemark = try await locationService.findNearestMapItem(at: Step.warsaw.coordinate)?.placemark {
                let placemark = Placemark(placemark: clPlacemark)
                placemark.steps.append(Step.warsaw)
            }
            
            if let clPlacemark = try await locationService.fetchPlacemark(for: Step.everestBaseCamp.coordinate) {
                let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 28.140913, longitude: 86.851709), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
                if let mapItem = try await mapItemSearchService.search(for: "Mount everest base camp", in: region) {
                    let placemark = Placemark(placemark: clPlacemark, mapItem: mapItem)
                    placemark.steps.append(Step.everestBaseCamp)
                } else {
                    let placemark = Placemark(placemark: clPlacemark)
                    placemark.steps.append(Step.everestBaseCamp)
                }
            }
            
            
            
            if let clPlacemark = try await locationService.fetchPlacemark(for: Step.statueOfLiberty.coordinate) {
                let placemark = Placemark(placemark: clPlacemark)
                placemark.steps.append(Step.statueOfLiberty)
            }
            
        } catch {
            
        }
        

        Trip.bedminsterToBeijing.steps.append(Step.stJohnsLane)
        Trip.bedminsterToBeijing.steps.append(Step.bedminsterStation)
        Trip.bedminsterToBeijing.steps.append(Step.templeMeads)
        Trip.bedminsterToBeijing.steps.append(Step.paddington)
        Trip.bedminsterToBeijing.steps.append(Step.stPancras)
        Trip.bedminsterToBeijing.steps.append(Step.brusselsMidi)
        Trip.bedminsterToBeijing.steps.append(Step.grandPlace)
        Trip.bedminsterToBeijing.steps.append(Step.atomium)
        Trip.bedminsterToBeijing.steps.append(Step.cologne)
        Trip.bedminsterToBeijing.steps.append(Step.warsaw)
        Trip.bedminsterToBeijing.steps.append(Step.everestBaseCamp)

    }

    /// A random image to display in trip view
    static var randomTripImage: ImageResource {
        let images: [ImageResource] = [.EBC_1, .EBC_2, .EBC_3]
        let randomInt = Int.random(in: 0...2)
        return images[randomInt]
    }
}
