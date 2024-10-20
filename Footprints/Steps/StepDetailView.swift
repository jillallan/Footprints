//
//  StepDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 06/10/2024.
//

import MapKit
import SwiftUI

struct StepDetailView: View {
    @State private var mapRegion = MapCameraPosition.automatic
    @Bindable var step: Step
//    var stepList: Namespace.ID
    
    var body: some View {
        MapReader { mapProxy in
            Map(position: $mapRegion) {
                Annotation(step.placemark?.name ?? "", coordinate: step.coordinate) {
                    DefaultStepMapAnnotation()
                }
            }
        }
        .onAppear {
            mapRegion = .region(step.region)
        }
        .safeAreaInset(edge: .bottom) {
            Image(.EBC_1)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        }
        .navigationTitle(step.placemark?.name ?? "Step")
//        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}

#Preview(traits: .previewData) {
    @Previewable @Namespace var namespace
    
    NavigationStack {
        StepDetailView(
            step: .atomium
//            , stepList: namespace
        )
    }
}
