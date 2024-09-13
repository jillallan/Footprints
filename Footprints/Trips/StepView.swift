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
            ForEach(trip.steps) { step in
                NavigationLink(value: step) {
                    Text(step.timestamp, style: .date)
                }
            }
        }
//        .listStyle(.plain)
//        .background(.background)
    }
}

#Preview(traits: .previewData) {
    StepView(trip: .bedminsterToBeijing)
}
