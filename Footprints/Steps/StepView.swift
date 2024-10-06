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
    @Binding var selectedStep: Step?
    var stepList: Namespace.ID

    var body: some View {

        ScrollViewReader { value in
            ScrollView {
                LazyVStack {
                    Section {
                        ForEach(trip.tripSteps) { step in
                            NavigationLink(value: step) {
                                StepRow(step: step)
                            }
                            .id(step)
                            .buttonStyle(.plain)
//                            .matchedTransitionSource(id: step.id, in: stepList)
                       
                        }
                    } header: {
                        Text(trip.startDate, style: .date)
                            .id(trip)

                    } footer: {
                        VStack {
                            Text("Summary")
                        }
                        .frame(height: 400)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition(id: $selectedStep)
            .scrollTargetBehavior(.viewAligned(limitBehavior: .alwaysByOne))
            .onChange(of: selectedStep) {
                withAnimation {
                    value.scrollTo(selectedStep, anchor: .top)
                }
            }
            .background(.background)
            .navigationTitle("Steps")
//            .navigationDestination(for: Step.self) { step in
//                AddStepView(step: step)
//            }
        }
    }
}

#Preview(traits: .previewData) {
    @Previewable @Namespace var namespace
    
    NavigationStack {
        StepView(
            trip: .bedminsterToBeijing,
            selectedStep: .constant(Step.bedminsterStation),
            stepList: namespace
        )
    }
    
}
