//
//  StepViewRow.swift
//  Footprints
//
//  Created by Jill Allan on 01/03/2024.
//

import SwiftUI

struct StepViewRow: View {
    // MARK: - Data properties
    @Bindable var step: Step
    
    var body: some View {
        VStack {

            LocationName(step: step, alignment: .leading)
            
            VStack(alignment: .leading) {
                Text(step.timestamp.formatted(date: .abbreviated, time: .shortened))
                HStack {
                    Text("Coordinate: ")
                    Spacer()
                    Text(step.latitude, format: .number)
                    Text(step.longitude, format: .number)
                }
                Text("Trip") + Text(step.trip?.title ?? "No trip")
            }
        }
    }
}

#Preview {
    ModelPreview(SampleContainer.sample) {
        List {
            StepViewRow(step: .bedminsterStation)
        }
    }
}
