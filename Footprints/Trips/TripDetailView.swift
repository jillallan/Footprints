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
    @Binding var navigationPath: NavigationPath
    @State private var width: CGFloat = .zero
    
    var body: some View {
        GeometryReader { geometry in
            Map()
                .safeAreaInset(edge: .bottom) {
                    ActivityScroll(trip: trip, navigationPath: $navigationPath)
                }
                .navigationTitle(trip.title)
    #if os(iOS)
                .toolbarBackground(.hidden, for: .navigationBar)
                .toolbar(.hidden, for: .tabBar)
                .task(id: geometry.size.width) {
                    width = geometry.size.width
                }
#endif
        }
    }
}

#Preview {
    ModelPreview(SampleContainer.sample) {
        TabView {
            NavigationStack {
                TripDetailView(trip: .bedminsterToBeijing, navigationPath: .constant(NavigationPath()))
            }
        }
    }
}
