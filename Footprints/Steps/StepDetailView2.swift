//
//  StepDetailView2.swift
//  Footprints
//
//  Created by Jill Allan on 23/03/2024.
//

import MapKit
import SwiftUI

struct StepDetailView2: View {
    @Bindable var step: Step
    @State private var stepPosition: MapCameraPosition = .automatic
    @State private var size: CGSize = .zero
    
    var body: some View {
        VStack {
            ScrollView {
                Map(position: $stepPosition) {
                    Marker("", coordinate: step.coordinate)
                }
                .frame(height: size.height * 0.25)
                VStack {
                    
                }
            }
        }
        .onAppear {
//            if let item = step.mapItem {
            stepPosition = .item(step.mapItem)
//            } else {
//                stepPosition = .region(
//                    MKCoordinateRegion(
//                        center: step.coordinate,
//                        span: MKCoordinateSpan(
//                            latitudeDelta: 0.001,
//                            longitudeDelta: 0.001
//                        )
//                    )
//                )
//            }
        }
        .getSize($size)
    }
}

#Preview {
    ModelPreview {
        SampleContainer.sample()
    } content: {
        StepDetailView2(step: .bedminsterStation)
    }
}
