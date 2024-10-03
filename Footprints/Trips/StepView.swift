//
//  StepView.swift
//  Footprints
//
//  Created by Jill Allan on 06/09/2024.
//

import SwiftData
import SwiftUI

struct StepView: View {
    
    @Bindable var trip: Trip
    @Binding var position: PersistentIdentifier?
    @Binding var selectedStep: Step?

    var body: some View {

        ScrollViewReader { value in
            ScrollView {
                LazyVStack {
                    Section {
                        ForEach(trip.steps) { step in
                            NavigationLink(value: step) {
                                StepRow(step: step)
                            }
                            .id(step)
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
            .scrollTargetBehavior(.viewAligned(limitBehavior: .alwaysByOne))
            .onChange(of: selectedStep) {
                withAnimation {
                    value.scrollTo(selectedStep, anchor: .top)
                }
            }
            .background(.background)
            .navigationTitle("Steps")
            .navigationDestination(for: Step.self) { step in
                Text(step.timestamp, style: .date)
            }
        }
    }
}

#Preview(traits: .previewData) {
    StepView(trip: .bedminsterToBeijing, position: .constant(Step.bedminsterStation.persistentModelID), selectedStep: .constant(Step.bedminsterStation))
}
