//
//  StepDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 02/11/2023.
//

import SwiftUI

struct StepDetailView: View {
    let step: Step
    
    var body: some View {
        Text(step.timestamp, format: .dateTime)
    }
}

//#Preview {
//    StepDetailView()
//}
