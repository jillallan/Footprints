//
//  StepInspector.swift
//  Footprints
//
//  Created by Jill Allan on 05/01/2024.
//

import MapKit
import SwiftUI

struct StepInspector: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    @Bindable var step: Step
    
    var body: some View {
        VStack {
            if !prefersTabNavigation {
                Map()
//                    .frame(height: 200)
            }
            Form {
                
                DatePicker("Step Date", selection: $step.timestamp, displayedComponents: [.date, .hourAndMinute])
                //                .labelsHidden()
            }
        }
    }
}

#Preview {
    ModelPreview(SampleContainer.sample) {
        NavigationStack {
            StepInspector(step: .bedminsterStation)
        }
    }
}
