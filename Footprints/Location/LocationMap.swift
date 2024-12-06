//
//  LocationMap.swift
//  Footprints
//
//  Created by Jill Allan on 19/11/2024.
//

import MapKit
import SwiftUI

struct LocationMap: View {
    let locationCoordinate: CLLocationCoordinate2D
    let mapItem: MKMapItem?
    @State var mapCameraPosition: MapCameraPosition = .automatic
    @State var isMapTappable: Bool = false
    @Binding var mapFeature: MapFeature?
    @Binding var tappedLocation: Coordinate?
    
    var body: some View {
        VStack {
            if isMapTappable {
                LocationEditingMap(
                    mapCameraPosition: $mapCameraPosition,
                    currentLocation: locationCoordinate,
                    tappedLocation: $tappedLocation
                )
            } else  {
                MapFeatureMap(
                    mapCameraPosition: $mapCameraPosition,
                    currentLocation: locationCoordinate,
                    mapFeature: $mapFeature
                )
            }
        }
        .overlay(alignment: .bottomTrailing) {
            MapToggle(isMapTappable: $isMapTappable)
                .padding(5)
        }
        .onAppear {
            mapCameraPosition = MapCameraPosition.region(locationCoordinate.region)
        }
        .onChange(of: isMapTappable) {
            tappedLocation = nil
            mapFeature = nil
        }
    }
}

#Preview("Coordiante only", traits: .previewData) {
    let locationCoordinate = Step.stPancras.coordinate
    LocationMap(
        locationCoordinate: locationCoordinate,
        mapItem: nil, mapFeature: .constant(nil),
        tappedLocation: .constant(nil)
    )
}

#Preview("Equator", traits: .previewData) {
    let locationCoordinate = CLLocationCoordinate2D(latitude: -0.030287, longitude: 109.333742)
    LocationMap(
        locationCoordinate: locationCoordinate,
        mapItem: nil, mapFeature: .constant(nil),
        tappedLocation: .constant(nil)
    )
}

#Preview("Tropic of cancer", traits: .previewData) {
    let locationCoordinate = CLLocationCoordinate2D(latitude: 23.53, longitude: 91.48) //23.531375, 91.486510
    LocationMap(
        locationCoordinate: locationCoordinate,
        mapItem: nil, mapFeature: .constant(nil),
        tappedLocation: .constant(nil)
    )
}

#Preview("Arctic Circle", traits: .previewData) {
    let locationCoordinate = CLLocationCoordinate2D(latitude: 66.534021, longitude: 66.632438)
    LocationMap(
        locationCoordinate: locationCoordinate,
        mapItem: nil, mapFeature: .constant(nil),
        tappedLocation: .constant(nil)
    )
}

#Preview("North Pole", traits: .previewData) {
    let locationCoordinate = CLLocationCoordinate2D(latitude: 85.0, longitude: 0.0)
    LocationMap(
        locationCoordinate: locationCoordinate,
        mapItem: nil, mapFeature: .constant(nil),
        tappedLocation: .constant(nil)
    )
}

#Preview("MapItem", traits: .previewData) {
    let locationCoordinate = Step.stPancras.coordinate
    let mapItem = Step.stPancras.location?.mapItem ?? MKMapItem(placemark: MKPlacemark(coordinate: Step.stPancras.coordinate))
    
    LocationMap(
        locationCoordinate: locationCoordinate,
        mapItem: nil, mapFeature: .constant(nil),
        tappedLocation: .constant(nil)
    )
}
