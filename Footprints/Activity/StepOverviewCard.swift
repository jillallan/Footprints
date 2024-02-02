//
//  StepOverviewCard.swift
//  Footprints
//
//  Created by Jill Allan on 26/12/2023.
//

import SwiftUI

struct StepOverviewCard: View {
    @Bindable var step: Step
    @State var stepName: String = "Hello"
    let image: Image
    
    var body: some View {
        image
            .resizable()
            .overlay {
                VStack {
                    TextField("", text: $stepName)
                    DatePicker(step.timestamp.formatted(date: .abbreviated, time: .shortened), selection: $step.timestamp, displayedComponents: [.date, .hourAndMinute])
                        .accentColor(.indigo)
               
           

                }
                .padding()
            }
    }
}

#Preview {
    ModelPreview(SampleContainer.sample) {
        StepOverviewCard(step: .bedminsterStation, image: Image(.beach))
    }
}
