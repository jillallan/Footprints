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
        
        ScrollView {
            DatePicker("Step Date", selection: $step.timestamp, displayedComponents: [.date, .hourAndMinute])
                .padding()
            LazyVStack {
                Map(position: $mapRegion) {
                    Annotation(step.placemark?.name ?? "", coordinate: step.coordinate) {
                        DefaultStepMapAnnotation()
                    }
                }
                .frame(height: 250)
                ForEach(0..<3) { int in
                    Image(.EBC_1)
                        .resizable()
                        .scaledToFit()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
            .padding()
            
        }
  

        .onAppear {
            mapRegion = .region(step.region)
        }
        .navigationTitle(step.placemark?.name ?? "Step")
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
