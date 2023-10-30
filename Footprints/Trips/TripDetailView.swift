//
//  TripDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 30/10/2023.
//

import MapKit
import SwiftUI

struct TripDetailView: View {
    @Bindable var trip: Trip
    
    var body: some View {
        Map()
            .safeAreaInset(edge: .bottom) {
                
            }
            .navigationTitle(trip.title)
            .toolbarBackground(.hidden, for: .navigationBar)
    }
}

#Preview {
    ModelPreview {
        NavigationStack {
            TripDetailView(trip: .bedminsterToBeijing)
        }
    }
}
