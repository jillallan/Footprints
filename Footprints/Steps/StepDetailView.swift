//
//  StepDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 06/10/2024.
//

import MapKit
import SwiftUI

struct StepDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var step: Step
    @State private var isEditLocationViewPresented: Bool = false
//    @State private var location: Location?
    
    var body: some View {
        ScrollView {
            DatePicker("Step Date", selection: $step.timestamp, displayedComponents: [.date, .hourAndMinute])
                .padding()
            LazyVStack {
                Button {
                    isEditLocationViewPresented.toggle()
                } label: {
                    StepMap(step: step)
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
        .navigationTitle(step.stepTitle)
        .toolbarBackground(.hidden, for: .navigationBar)
        .sheet(isPresented: $isEditLocationViewPresented) {
            // TODO: -
        } content: {
            LocationDetailView(currentLocation: step.coordinate) { location in
                
            }
        
//            EditLocationView(mapItem: step.location?.mapItem) { locationID in
//                guard let locationID else { return }
//                if let location = modelContext.model(for: locationID) as? Location {
//                    step.location = location
//                }
//            }
        }
    }
    
    func addToStep(location: Location) {
        location.steps.append(step)
    }
}

#Preview(traits: .previewData) {
    
    NavigationStack {
        StepDetailView(
            step: .stJohnsLane
        )
    }
}
