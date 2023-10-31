//
//  TripDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 30/10/2023.
//

import MapKit
import SwiftData
import SwiftUI

struct TripDetailView: View {
    @Bindable var trip: Trip
    
    var body: some View {
        Map()
            .safeAreaInset(edge: .bottom) {
                
            }
            .navigationTitle(trip.title)
#if os(iOS)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbar(.hidden, for: .tabBar)
#endif
    }
}

#Preview {
    ModelPreview(SampleContainer.sample) {
        TabView {
            NavigationStack {
                TripDetailView(trip: .bedminsterToBeijing)
            }
        }
    }
}
