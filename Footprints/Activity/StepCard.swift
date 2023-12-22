//
//  StepCard.swift
//  Footprints
//
//  Created by Jill Allan on 12/11/2023.
//

import SwiftUI

struct StepCard: View {
    let step: Step
    let image: Image
    
    var body: some View {
        image
//        Image(uiImage: image)
            .resizable()
            .overlay {
                VStack {
                    Text(step.timestamp, style: .date)
                    Text(step.timestamp, style: .time)
                }
                .foregroundStyle(Color.white)
            }
    }
}

#Preview {
    ModelPreview(SampleContainer.sample) {
        StepCard(step: .bedminsterStation, image: Image(.beach))
    }
}
