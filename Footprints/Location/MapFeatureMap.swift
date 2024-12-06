//
//  MapFeatureMap.swift
//  Footprints
//
//  Created by Jill Allan on 23/11/2024.
//

import MapKit
import OSLog
import SwiftUI

struct MapFeatureMap: View {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: EditLocationView.self)
    )
    
    @Binding var mapCameraPosition: MapCameraPosition
    let currentLocation: CLLocationCoordinate2D?
    @Binding var mapFeature: MapFeature?
    
    var body: some View {
        Map(position: $mapCameraPosition, selection: $mapFeature) {
            if let currentLocation {
                Marker("", coordinate: currentLocation)
            }
        }
        .onMapCameraChange { context in
            let _ = logger.debug("Updated map region: \(String(describing: context.region))")
            mapCameraPosition = .region(context.region)
        }
    }
}

//#Preview {
//    MapFeatureMap()
//}
