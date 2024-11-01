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
    @State private var isStepEditingViewPresented: Bool = false
//    var stepList: Namespace.ID
    
    var body: some View {
        
        ScrollView {
            DatePicker("Step Date", selection: $step.timestamp, displayedComponents: [.date, .hourAndMinute])
                .padding()
            LazyVStack {
                Button {
                    isStepEditingViewPresented.toggle()
                } label: {
                    Map(position: $mapRegion) {
                        Annotation(step.location?.name ?? "", coordinate: step.coordinate) {
                            DefaultStepMapAnnotation()
                        }
                    }
                    .frame(height: 250)
                }
                .buttonStyle(.plain)

                
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
        .navigationTitle(step.stepTitle)
        .toolbarBackground(.hidden, for: .navigationBar)
        .sheet(isPresented: $isStepEditingViewPresented) {
            StepEditingView(step: step)
                .presentationDragIndicator(.visible)
        }
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
