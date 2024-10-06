//
//  PopulatedStepMapAnnotation.swift
//  Footprints
//
//  Created by Jill Allan on 04/10/2024.
//

import SwiftUI

struct PopulatedStepMapAnnotation: View {
    var body: some View {
        Image(PreviewDataGenerator.randomTripImage)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 25)
            .clipShape(.circle)
            .overlay(Circle().stroke(Color.white, lineWidth: 25/10))
    }
}

#Preview {
    PopulatedStepMapAnnotation()
}
