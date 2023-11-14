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
    
    var activityScrollEdge: EdgeCustom {
        .leading
    }
    
    var verticleEdge: VerticalEdge? {
        switch activityScrollEdge {
        case .top:
            return VerticalEdge.top
        case .bottom:
            return VerticalEdge.bottom
        default:
            return nil
        }
    }
    
    var horizontalEdge: HorizontalEdge? {
        switch activityScrollEdge {
        case .leading:
            return HorizontalEdge.leading
        case .trailing:
            return HorizontalEdge.trailing
        default:
            return nil
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            Map()
                .if(verticleEdge != nil) { map in
                    map.safeAreaInset(edge: verticleEdge ?? .top) {
                        ActivityScroll(trip: trip, navigationPath: $navigationPath)
                    }
                }
                .if(horizontalEdge != nil) { map in
                    map.safeAreaInset(edge: horizontalEdge ?? .leading) {
                        ActivityScroll(trip: trip, navigationPath: $navigationPath)
                    }
                }
            
            
//                .safeAreaInset(edge: .bottom) {
//                    ActivityScroll(trip: trip, navigationPath: $navigationPath)
//                }
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
