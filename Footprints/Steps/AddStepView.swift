//
//  AddStepView.swift
//  Footprints
//
//  Created by Jill Allan on 06/10/2024.
//

import MapKit
import SwiftUI

struct AddStepView: View {
    @Environment(\.modelContext) var modelContext
    let trip: Trip
    @Bindable var step: Step
    @State var stepIsNotSet: Bool = true
    @State var mapRegion = MapCameraPosition.region(MKCoordinateRegion.defaultRegion())
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        MapReader { mapProxy in
            Map(initialPosition: mapRegion) {
                if step.hasChanges {
                    Annotation("", coordinate: step.coordinate) {
                        DefaultStepMapAnnotation()
                    }
                }
            }
            .onTapGesture { value in
                if let coordinate = mapProxy.convert(value, from: .local) {
                    print("tapped at: \(coordinate)")
                    step.latitude = coordinate.latitude
                    step.longitude = coordinate.longitude
                    stepIsNotSet = false
                }
            }
        }
        .navigationTitle("Add step view")
#if !os(macOS)
        .toolbarBackground(.hidden, for: .navigationBar)
        
    
#elseif os(macOS)
        .toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
        //        .navigationTransition(.automatic)
#endif
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("back", systemImage: "chevron.left") {
                    print("Step has changes: \(step.hasChanges)")
                    deleteStep()
                    dismiss()
                }
            }
        }
    }
    
    func deleteStep() {
        print(stepIsNotSet)
        if stepIsNotSet {
            if let stepIndex = trip.steps.firstIndex(of: step) {
                trip.steps.remove(at: stepIndex)
            }
            modelContext.delete(step)
        }
    }
}

#Preview(traits: .previewData) {
    NavigationStack {
        AddStepView(trip: .bedminsterToBeijing, step: .atomium)
    }
    
}
