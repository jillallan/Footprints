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
    @Environment(\.aspectRatio) private var aspectRatio
    @Bindable var trip: Trip
    @Binding var navigationPath: NavigationPath
    
    var activityScrollEdge: EdgeCustom {
        switch aspectRatio {
        case .wide(_):
            return .leading
        case .landscape(_):
            return .leading
        case .square(_):
            return .bottom
        case .portrait(_):
            return .bottom
        case .tall(_):
            return .bottom
        case .zero(AspectRatio: _):
            return .bottom
        }
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
                TripDetailView(trip: .bedminsterToBeijing, navigationPath: .constant(NavigationPath()))
            }
        }
    }
}
