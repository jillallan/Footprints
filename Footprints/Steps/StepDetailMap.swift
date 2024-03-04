//
//  StepDetailMap.swift
//  Footprints
//
//  Created by Jill Allan on 23/02/2024.
//

import MapKit
import SwiftUI

struct StepDetailMap: View {
    @State private var stepPosition: MapCameraPosition = .automatic
    @State private var userLocationPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    let isNewStep: Bool
    @Bindable var step: Step
    @Binding var searchResults: [MKMapItem]
    
    var body: some View {
        Map(position: isNewStep ? $userLocationPosition : $stepPosition) {
            Marker("", coordinate: step.coordinate)
            ForEach(searchResults) { result in
                Marker(item: result)
            }
        }
        .onAppear {
            stepPosition = .item(step.mapItem)
        }
        .onChange(of: searchResults) {
            stepPosition = .automatic
            userLocationPosition = .automatic
        }
    }
}

#Preview {
    ModelPreview(SampleContainer.sample) {
        StepDetailMap(isNewStep: false, step: .bedminsterStation, searchResults: .constant([]))
    }
}
