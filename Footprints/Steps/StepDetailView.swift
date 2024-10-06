//
//  StepDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 06/10/2024.
//

import SwiftUI

struct StepDetailView: View {
    @Bindable var step: Step
    var stepList: Namespace.ID
    
    var body: some View {
        
        VStack {
            Text("Step")
        }
//        .navigationTransition(.zoom(sourceID: step.id, in: stepList))
    }
}

#Preview(traits: .previewData) {
    @Previewable @Namespace var namespace
    
    StepDetailView(step: .bedminsterStation, stepList: namespace)
}
