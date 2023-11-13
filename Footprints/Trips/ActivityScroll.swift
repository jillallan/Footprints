//
//  ActivityScroll.swift
//  Footprints
//
//  Created by Jill Allan on 10/11/2023.
//

import SwiftUI

struct ActivityScroll: View {
    let trip: Trip
    @Binding var navigationPath: NavigationPath
    @State var width: CGFloat = .zero
    
    var body: some View {

        ScrollView(.horizontal) {
            LazyHStack {
                ForEach([trip]) { trip in
                    Section {
                        if trip.tripSteps.isEmpty {
                            AddFirstStepCard()
                        } else {
                            StepCard(image: UIImage(resource: .beach))
                        }
                        
                    } header: {
                        TripSummaryCard()
                    } footer: {
                        TripStatisticsCard()
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .circular))
                .containerRelativeFrame([.horizontal], count: 1, spacing: 0.0)
            }
        }
        .getWidth($width)
        .frame(height: width / 1.5)
    }
}

#Preview {
    ModelPreview(SampleContainer.sample) {
        GeometryReader { geometry in
            NavigationStack {
                ActivityScroll(
                    trip: .bedminsterToBeijing, 
                    navigationPath: .constant(NavigationPath())
                )
            }
        }
    }
}


