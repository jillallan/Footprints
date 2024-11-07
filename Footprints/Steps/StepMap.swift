//
//  StepMap.swift
//  Footprints
//
//  Created by Jill Allan on 07/11/2024.
//

import MapKit
import SwiftUI

struct StepMap: View {
    let step: Step
    @Binding var mapItem: MKMapItem?
    
    var body: some View {
        Map(initialPosition: step.mapRegion) {
            if let mapItem {
                Marker(item: mapItem)
            } else {
                Annotation(step.location?.name ?? "", coordinate: step.coordinate) {
                    DefaultStepMapAnnotation()
                }
            }
        }
        .frame(height: 250)
    }
}

#Preview {
    let placemark = MKPlacemark(coordinate: Step.brusselsMidi.coordinate)
    let mapItem = MKMapItem(placemark: placemark)
    StepMap(step: .brusselsMidi, mapItem: .constant(mapItem))
}
