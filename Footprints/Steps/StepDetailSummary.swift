//
//  StepDetailSummary.swift
//  Footprints
//
//  Created by Jill Allan on 23/02/2024.
//

import SwiftUI

struct StepDetailSummary: View {
    @Bindable var step: Step
    let editorTitle: String
    @Binding var isLocationSearchViewPresented: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(editorTitle) {
                isLocationSearchViewPresented.toggle()
            }
            .buttonStyle(.plain)
            .font(.title)
            
            DatePicker("Date", selection: $step.timestamp, displayedComponents: [.date, .hourAndMinute])
            
            PhotoGrid()
        }
        .padding()
    }
}

#Preview {
    ModelPreview(SampleContainer.sample) {
        ScrollView {
            StepDetailSummary(step: Step.bedminsterStation, editorTitle: Step.bedminsterStation.location?.title ?? "New Step", isLocationSearchViewPresented: .constant(false))
        }
    }
}
