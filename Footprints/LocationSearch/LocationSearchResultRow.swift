//
//  LocationSearchSuggestionRow.swift
//  Footprints
//
//  Created by Jill Allan on 19/01/2024.
//

import MapKit
import SwiftUI

struct LocationSearchResultRow: View {
    let mapItem: MKMapItem
    @State var resultClosure: (MKMapItem) -> ()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(mapItem.placemark.name ?? "No title")
                    .font(.headline)
                Text(mapItem.placemark.subtitle ?? "No subtitle")
                    .font(.subheadline)
            }
            Spacer()
            Button("Add") {
                resultClosure(mapItem)
            }
            .buttonStyle(.bordered)
        }
    }
}

//struct LocationSearchResultRow_Preview: PreviewProvider {
//    static var previews: some View {
//        let coordinate = CLLocationCoordinate2D(latitude: 51.500685, longitude: -0.124570)
//        let placemark = MKPlacemark(coordinate: coordinate)
//        let mapItem = MKMapItem(placemark: placemark)
//        
//        List {
////            Loca
//            LocationSearchResultRow(
//                mapItem: mapItem, 
//                dismissSearchView: .constant(false)) { _ in }
//        }
//    }
//}
