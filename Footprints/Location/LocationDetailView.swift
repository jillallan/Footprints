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
    @State private var isPlacemarkSheetPresented: Bool = false
    @State private var isMapItemSheetPresented: Bool = false
    let mapItem: (MKMapItem?) -> Void
    
    enum MapType: String, CaseIterable, Identifiable {
        case mapFeatures, anyLocation
        var id: Self { self }
    }

    @State private var selectedMap: MapType = .mapFeatures
    
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
                switch selectedMap {
                case .mapFeatures:
                    MapFeatureMap(
                        mapCameraPosition: $mapCameraPosition,
                        currentLocation: currentLocation,
                        mapFeature: $mapFeature
                    )
                case .anyLocation:
                    TappedLocationMap(
                        mapCameraPosition: $mapCameraPosition,
                        currentLocation: currentLocation,
                        tappedLocation: $tappedLocation
                    )
                }
            }
            .overlay(alignment: .top) {
                Picker("Map Type", selection: $selectedMap) {
                    Text("Map Features").tag(MapType.mapFeatures)
                    Text("Any Location").tag(MapType.anyLocation)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
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
                mapItem(selectedMapItem)
                dismiss()
            } content: {
                if let tappedLocation {
                    TappedLocationDetail(
                        coordinate: tappedLocation,
                        mapItem: $selectedMapItem
                    )
                    .mapDetailPresentationStyle()
                }
            }
            .sheet(isPresented: $isMapItemSheetPresented) {
                mapItem(selectedMapItem)
                dismiss()
            } content: {
                if let mapFeature {
                    MapFeatureDetail(
                        mapFeature: mapFeature,
                        mapItem: $selectedMapItem
                    )
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
            .onChange(of: selectedMap) {
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
