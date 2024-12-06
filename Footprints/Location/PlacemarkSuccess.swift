//
//  PlacemarkSuccess.swift
//  Footprints
//
//  Created by Jill Allan on 16/11/2024.
//

import MapKit
import SwiftUI

struct PlacemarkSuccess: View {
    let placemark: MKPlacemark
    
    var body: some View {

        Group {
            Section {
                Text(placemark.localAddressString ?? "")
                    .backgroundStyle(.primary)
            } header: {
                Label(placemark.placemarkType.rawValue.capitalized(with: Locale.current), systemImage: "car")
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
    let coordinate = Coordinate(latitude: 51.5050, longitude: 0.0123)
    let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(from: coordinate))
    List {
        PlacemarkSuccess(placemark: placemark)
    }
}
