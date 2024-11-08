//
//  EditLocationMap.swift
//  Footprints
//
//  Created by Jill Allan on 08/11/2024.
//

import MapKit
import SwiftUI

struct EditLocationMap: View {
    @Binding var location: Location
    @State var mapCameraPosition: MapCameraPosition = .automatic
    @Binding var mapSelection: MapSelection<MKMapItem>?
    
    var body: some View {
        Map(position: $mapCameraPosition, selection: $mapSelection) {
            Marker(item: location.mapItem)
                .tag(MapSelection(location.mapItem))
        }
        .onAppear {
            mapCameraPosition = .item(location.mapItem)
        }
    }
}

#Preview(traits: .previewData) {
    let location = Step.stJohnsLane.location ?? Location(coordinate: Step.stJohnsLane.coordinate)
    EditLocationMap(
        location: .constant(location),
        mapSelection: .constant(MapSelection(location.mapItem))
    )
}
