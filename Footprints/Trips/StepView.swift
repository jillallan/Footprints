//
//  StepView.swift
//  Footprints
//
//  Created by Jill Allan on 06/09/2024.
//

import SwiftData
import SwiftUI

struct StepView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var trip: Trip
    @State private var position: PersistentIdentifier?
    @State private var currentStep: Step?

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
                } footer: {
                    VStack {
                        Text("Summary")
                    }
                    .frame(height: 400)
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $position)
        .background(.background)
        .navigationTitle("Steps")
        .navigationDestination(for: Step.self) { step in
            Text(step.timestamp, style: .date)
        }
        .onChange(of: position) {
            let step = getStep(for: position)
            print(step?.timestamp.formatted(date: .abbreviated, time: .shortened) ?? Date.now)
        }
    }

    func getStep(for id: PersistentIdentifier?) -> Step? {
        guard let id else { return nil }
        guard let step = modelContext.model(for: id) as? Step else {
            return nil
        }
        return step
    }
}

#Preview(traits: .previewData) {
    StepView(trip: .bedminsterToBeijing)
}
