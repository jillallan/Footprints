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
    let aspectRatio: CGFloat
    
    var body: some View {
        image
//        Image(uiImage: image)
            .resizable()
            
            .aspectRatio(aspectRatio, contentMode: .fit)
//            .scaledToFill()
//            .scaledToFill()
            .overlay {
                VStack {
                    Text(step.timestamp, style: .date)
                    Text(step.timestamp, style: .time)
                }
                .frame(maxWidth: .infinity, maxHeight:  .infinity)
                .foregroundStyle(Color.white)
            }
            
    }
}

#Preview {
    ModelPreview(SampleContainer.sample) {
        StepCard(step: .bedminsterStation, image: Image(.beach), aspectRatio: 1.5)
    }
}
