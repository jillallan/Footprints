//
//  TripDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 03/09/2024.
//

import MapKit
import SwiftUI

struct TripDetailView: View {
    @Bindable var trip: Trip
    var tripList: Namespace.ID

    var body: some View {
        VStack {
            Map()
            Text("\(trip.title)")
                .foregroundStyle(Color.white)
        }

#if os(macOS)
        .navigationTransition(.automatic)
#else
        .navigationTransition(.zoom(sourceID: trip.id, in: tripList))
#endif
        
    }
}

#Preview(traits: .previewData) {
    @Previewable @Namespace var namespace
    return TripDetailView(trip: .anglesey, tripList: namespace)
}
