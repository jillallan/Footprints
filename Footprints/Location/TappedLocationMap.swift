//
//  TappedLocationMap.swift
//  Footprints
//
//  Created by Jill Allan on 16/11/2024.
//

import MapKit
import OSLog
import SwiftUI

struct TappedLocationMap: View {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: EditLocationView.self)
    )
    
    @Binding var mapCameraPosition: MapCameraPosition
    let currentLocation: CLLocationCoordinate2D?
    @Binding var tappedLocation: Coordinate?
    
    var body: some View {
        MapReader { mapProxy in
            Map(position: $mapCameraPosition) {
                if let currentLocation {
                    Marker("", coordinate: currentLocation)
                }
            }
            .onTapGesture { position in
                if let clLocationCoordinate = mapProxy.convert(position, from: .local) {
                    let _ = logger.debug("Map tapped at: \(String(describing: clLocationCoordinate))")
                    tappedLocation = Coordinate(from: clLocationCoordinate)
                }
            }
            .onMapCameraChange { context in
                let _ = logger.debug("Updated map region: \(String(describing: context.region))")
                mapCameraPosition = .region(context.region)
            }
        }
    }
}

#Preview {
    
    let currentLocation = CLLocationCoordinate2D(latitude: 51.5, longitude: 0.0)
    let region = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 500, longitudinalMeters: 500)
    let mapCameraPosition: MapCameraPosition = .region(region)
    
    TappedLocationMap(
        mapCameraPosition: .constant(mapCameraPosition),
        currentLocation: currentLocation,
        tappedLocation: .constant(nil)
    )
}
