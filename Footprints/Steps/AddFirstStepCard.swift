//
//  AddFirstStepCard.swift
//  Footprints
//
//  Created by Jill Allan on 12/11/2023.
//

import SwiftUI

struct AddFirstStepCard: View {
    var body: some View {
        ContentUnavailableView {
            Label("No Steps Added Yet", systemImage: "tray.fill")
        } description: {
            Text("Add your first step.")
        } actions: {
            Button("Add Step") {
                // TODO: Add step
            }
        }
        .background(.regularMaterial)
    }
}

#Preview {
    AddFirstStepCard()
}
