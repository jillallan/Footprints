//
//  LocationDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 15/11/2024.
//

import MapKit
import SwiftUI

struct LocationDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var currentLocation: CLLocationCoordinate2D
    @State var tappedLocation: Coordinate?
    @State var mapFeature: MapFeature?
    @State var selectedMapItem: MKMapItem?
    @State var location: Location?
    @State var mapCameraPosition: MapCameraPosition = .automatic
    @State var isMapTappable: Bool = false
    @State private var isPlacemarkSheetPresented: Bool = false
    @State private var isMapItemSheetPresented: Bool = false
    let mapItem: (MKMapItem?) -> Void
    
    var safeAreaInset: Double {
        if isPlacemarkSheetPresented || isMapItemSheetPresented {
            300
        } else {
            0
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if isMapTappable {
                    LocationEditingMap(
                        mapCameraPosition: $mapCameraPosition,
                        currentLocation: currentLocation,
                        tappedLocation: $tappedLocation
                    )
                } else  {
                    MapFeatureMap(
                        mapCameraPosition: $mapCameraPosition,
                        currentLocation: currentLocation,
                        mapFeature: $mapFeature
                    )
                }
            }
            .overlay(alignment: .bottomTrailing) {
                MapToggle(isMapTappable: $isMapTappable)
                    .padding(5)
            }
            .safeAreaInset(edge: .bottom) {
                Color.clear
                    .frame(height: safeAreaInset)
            }
            // MARK: Navigation
            .navigationTitle("Location Details")
            .toolbarBackground(.hidden, for: .navigationBar)
            // Is sheet(isPresented) used here instead of sheet(item) otherwise when the item changes the view is dismissed rather than updated
            .sheet(isPresented: $isPlacemarkSheetPresented) {
                if let tappedLocation {
                    LocationDetailSheet2(coordinate: tappedLocation, location: $location)
                        .mapDetailPresentationStyle()
                }
            }
            .sheet(isPresented: $isMapItemSheetPresented) {
                mapItem(selectedMapItem)
                dismiss()
            } content: {
                if let mapFeature {
                    MapItemDetail(mapFeature: mapFeature, mapItem: $selectedMapItem)
                        .mapDetailPresentationStyle()
                }
            }
    
            // MARK: View Updates
            .onAppear {
                mapCameraPosition = MapCameraPosition.region(currentLocation.region)
            }
            .onChange(of: tappedLocation) {
                isPlacemarkSheetPresented = true
            }
            .onChange(of: mapFeature) {
                isMapItemSheetPresented = true
            }
            .onChange(of: isMapTappable) {
                isMapItemSheetPresented = false
                isPlacemarkSheetPresented = false
            }
        }
    }
}

#Preview("London") {

    let coordinate = CLLocationCoordinate2D.defaultCoordinate()
    LocationDetailView(currentLocation: coordinate) { _ in
        
    }
}

#Preview("Bristol", traits: .previewData) {
    let coordinate = Step.bedminsterStation.coordinate
    LocationDetailView(currentLocation: coordinate) { _ in
        
    }
}
