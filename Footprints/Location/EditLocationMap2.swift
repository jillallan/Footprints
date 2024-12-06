//
//  EditLocationMap.swift
//  Footprints
//
//  Created by Jill Allan on 08/11/2024.
//

import MapKit
import SwiftUI

struct EditLocationMapOld: View {
    @Environment(\.dismissSearch) var dismissSearch
    @Binding var mapItem: MKMapItem?
    @State var mapCameraPosition: MapCameraPosition = .automatic
    @Binding var mapSelection: MapSelection<MKMapItem>?
    @Binding var tappedLocation: Coordinate?
    
    var body: some View {
        MapReader { mapProxy in
            Map(position: $mapCameraPosition, selection: $mapSelection) {
                if let mapItem {
                    Marker(item: mapItem)
                        .tag(MapSelection(mapItem))
                }
            }
            .onTapGesture { position in
                if let clLocationCoordinate = mapProxy.convert(position, from: .local) {
                    print("Tapped at \(clLocationCoordinate)")
                    let coordinate = Coordinate(
                        latitude: clLocationCoordinate.latitude,
                        longitude: clLocationCoordinate.longitude
                    )
                    tappedLocation = coordinate
                }
            }
            .onAppear {
                if let mapItem {
                    mapCameraPosition = .item(mapItem)
                }
            }
            .onChange(of: mapItem) {
                dismissSearch()
            }
        }
    }
}

#Preview(traits: .previewData) {
    let placemark = MKPlacemark(coordinate: Step.stJohnsLane.coordinate)
    var mapItem = MKMapItem(placemark: placemark)
   
    EditLocationMapOld(
        mapItem: .constant(mapItem),
        mapSelection: .constant(MapSelection(mapItem)),
        tappedLocation: .constant(nil)
    )
}
