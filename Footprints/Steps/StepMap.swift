//
//  StepMap.swift
//  Footprints
//
//  Created by Jill Allan on 07/11/2024.
//

import MapKit
import SwiftUI

struct StepMap: View {
    @Bindable var step: Step
    
    var body: some View {
        Map(initialPosition: MapCameraPosition.item(step.mapItem)) {
            Marker(item: step.mapItem)
        }
        .frame(height: 250)
    }
}

#Preview {
    StepMap(step: .bedminsterStation)
}
