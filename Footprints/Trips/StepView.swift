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
        VStack {
            Text("Jan - Feb 2024")
            List {
                ForEach(trip.steps) { step in
                    NavigationLink(value: step) {
                        StepRow(step: step)
                    }
                }
            }
            .listStyle(.plain)
            .background(.background)
        }
    }
}

#Preview(traits: .previewData) {
    StepView(trip: .bedminsterToBeijing)
}
