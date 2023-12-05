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
    @State var aspectRatio: AspectRatio = .zero(AspectRatio: 0.0)
    
    var activityScrollEdge: EdgeCustom {
        switch aspectRatio {
        case .landscape(_), .wide(_):
            return .leading
        case .square(_), .portrait(_), .tall(_), .zero(AspectRatio: _):
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
        let _ = print("aspectRatio tripDetailView :\(aspectRatio)")
        let _ = print("verticleEdge :\(String(describing: verticleEdge))")
        let _ = print("horizontalEdge :\(String(describing: horizontalEdge))")
        VStack {
            Map()
                .if(verticleEdge != nil) { map in
                    map.safeAreaInset(edge: verticleEdge ?? .bottom) {
                        ActivityScroll(trip: trip, navigationPath: $navigationPath, aspectRatio: $aspectRatio)
                    }
                }
            
                .if(horizontalEdge != nil) { map in
                    map.safeAreaInset(edge: horizontalEdge ?? .leading) {
                        ActivityScroll(trip: trip, navigationPath: $navigationPath, aspectRatio: $aspectRatio)
                    }
                }
                .navigationTitle(trip.title)

#if os(iOS)
                .toolbarBackground(.hidden, for: .navigationBar)
                .toolbar(.hidden, for: .tabBar)
#endif
        }
        .getAspectRatio($aspectRatio)
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
