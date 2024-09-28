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
        ScrollView {
            LazyVStack {
                Section {
                    ForEach(trip.steps) { step in
                        NavigationLink(value: step) {
                            StepRow(step: step)
                        }
                        .buttonStyle(.plain)
                    }
                } header: {
                    Text(trip.startDate, style: .date)
                }
            }
        }
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
