//
//  StepView.swift
//  Footprints
//
//  Created by Jill Allan on 06/09/2024.
//

import SwiftUI

struct StepView: View {
    @Bindable var trip: Trip

    var body: some View {
        List {
            Section {
                ForEach(trip.steps) { step in
                    NavigationLink(value: step) {
                        StepRow(step: step)
                    }
                }
            } header: {
                Text(trip.startDate, style: .date)
            }
        }
        .listStyle(.plain)
        .background(.background)
        .navigationTitle("Steps")
        .navigationDestination(for: Step.self) { step in
            Text(step.timestamp, style: .date)
        }
    }
}

#Preview(traits: .previewData) {
    StepView(trip: .bedminsterToBeijing)
}
