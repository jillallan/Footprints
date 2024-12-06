//
//  MapItemSuccess.swift
//  Footprints
//
//  Created by Jill Allan on 22/11/2024.
//

import MapKit
import SwiftUI

struct MapItemSuccess: View {
    let mapItem: MKMapItem
    
    var body: some View {
        Group {
            Section {
                Text(mapItem.name ?? "")
                    .backgroundStyle(.primary)
            } header: {
                Label(mapItem.pointOfInterestCategory?.rawValue ?? "Other", systemImage: "car")
            }
//            Text(placemark.inlandWater ?? "No inland water")
//            Text(placemark.areasOfInterest?.first ?? "")
//            Text(placemark.firstLineOfAddress ?? "")
//            Text(placemark.localitySublocality ?? "")
//            Text(placemark.administrativeAreaSubAdministrativeArea ?? "")

        }
    }
}

#Preview {
    MapItemSuccess(mapItem: MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D.defaultCoordinate())))
}
