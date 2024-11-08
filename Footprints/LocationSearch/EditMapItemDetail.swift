//
//  EditMapItemDetail.swift
//  Footprints
//
//  Created by Jill Allan on 08/11/2024.
//

import MapKit
import SwiftUI

struct EditMapItemDetail: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var loadingState: LoadingState
    @Binding var mapItem: MKMapItem?
    let mapItemClosure: (MKMapItem?) -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                switch loadingState {
                case .loading: MapItemLoadingView()
                case .success: if let mapItem { MapItemSuccessView(mapItem: mapItem) }
                case .failed: MapItemFailedView()
                }
            }
            .navigationTitle(mapItem?.name ?? "Unknown Location")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Select") {
                        mapItemClosure(mapItem)
                        dismiss()
                        // TODO: -
                    }
                }
            }
        }
    }
}

#Preview {
    let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D.defaultCoordinate())
    let mapItem = MKMapItem(placemark: placemark)
    let mapItemClosure: (MKMapItem?) -> Void = { _ in }
    NavigationStack {
        EditMapItemDetail(loadingState: .constant(.success), mapItem: .constant(mapItem), mapItemClosure: mapItemClosure)
    }
}
