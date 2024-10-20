//
//  StepEditingView.swift
//  Footprints
//
//  Created by Jill Allan on 18/10/2024.
//

import MapKit
import SwiftUI

struct StepEditingView: View {
    @Bindable var step: Step
    @State private var mapRegion = MapCameraPosition.automatic
    
    enum LoadingState {
        case empty, loading, success, failed
    }
    
    var body: some View {
        MapReader { mapProxy in
            Map(position: $mapRegion)
        }
    }
}

#Preview {
    StepEditingView(step: .atomium)
}
