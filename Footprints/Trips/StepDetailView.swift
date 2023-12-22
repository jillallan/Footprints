//
//  StepDetailView.swift
//  Footprints
//
//  Created by Jill Allan on 02/11/2023.
//

import MapKit
import SwiftUI

struct StepDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
//    @Bindable var step: Step
    let step: Step
    @State var timestamp: Date
    
    var body: some View {
        Map(position: .constant(.automatic)) {
            // TODO: Add current position marker
        }
        .safeAreaInset(edge: .bottom) {
            Form {
                DatePicker("Date", selection: $timestamp)
            }
        }
        Text(step.timestamp, format: .dateTime)
            .navigationBarBackButtonHidden()
        
            .toolbar {
           
                
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        modelContext.delete(step)
                        dismiss()
                        
                    }
                }
            }
    }
}

//#Preview {
//    StepDetailView()
//}
