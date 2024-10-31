//
//  StepRow.swift
//  Footprints
//
//  Created by Jill Allan on 13/09/2024.
//

import SwiftUI

struct StepRow: View {
    @Bindable var step: Step

    var body: some View {
        HStack {
            Image(systemName: "car")
                .font(.title)
                .foregroundStyle(Color.pink)
            VStack(alignment: .leading) {
                Text(step.stepTitle ?? "")
                    .font(.headline)
                Text(step.timestamp.formatted(date: .abbreviated, time: .shortened))
                    .font(.subheadline)
            }
            Spacer()
        }
        .padding(.all, 10)
    }
}

#Preview(traits: .previewData) {
    StepRow(step: .bedminsterStation)
}
